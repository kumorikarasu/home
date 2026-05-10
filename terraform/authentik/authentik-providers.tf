# Generate random client secret for Cloudflare Access OAuth2 provider
resource "random_password" "cloudflare_access_secret" {
  length  = 64
  special = true
}

# OAuth2/OpenID Connect provider for Cloudflare Access
resource "authentik_provider_oauth2" "cloudflare_access" {
  name               = "Cloudflare Access"
  client_id          = "cloudflare-access"
  client_secret      = random_password.cloudflare_access_secret.result
  authorization_flow = data.authentik_flow.default_authorization_flow.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://${var.cloudflare_team_domain}.cloudflareaccess.com/cdn-cgi/access/callback"
    }
  ]

  sub_mode = "user_username"
  include_claims_in_id_token = true

  # Use RS256 for asymmetric signing (required for JWKS)
  signing_key = data.authentik_certificate_key_pair.default.id

  # Include default scope mappings for email, openid, and profile
  property_mappings = [
    data.authentik_property_mapping_provider_scope.scope_email.id,
    data.authentik_property_mapping_provider_scope.scope_openid.id,
    data.authentik_property_mapping_provider_scope.scope_profile.id
  ]
}

# Scope mapping to set Remote-User header (fixed for proxy provider)
resource "authentik_property_mapping_provider_scope" "remote_user_mapping" {
  name       = "Remote-User Header Mapping"
  scope_name = "ak_proxy"
  expression = <<EOF
return {
    "ak_proxy": {
        "user_attributes": {
            "additionalHeaders": {
                "Remote-User": request.user.email,
                "X-Remote-User": request.user.email
            }
        }
    }
}
EOF
}

# Proxy Provider that maps Cloudflare headers to SillyTavern
resource "authentik_provider_proxy" "sillytavern_proxy" {
  name               = "SillyTavern Proxy"
  authorization_flow = data.authentik_flow.default_authorization_flow.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id

  external_host = "https://st-test.home.ryougi.ca"
  internal_host = "https://st.home.ryougi.ca"

  mode = "forward_single"
  intercept_header_auth = true

  # Token validity and session settings
  access_token_validity  = "hours=24"
  refresh_token_validity = "days=30"

  # Add property mapping for Remote-User headers
  property_mappings = [authentik_property_mapping_provider_scope.remote_user_mapping.id]
}
