# Get default flows
data "authentik_flow" "default_authorization_flow" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "default_invalidation_flow" {
  slug = "default-invalidation-flow"
}

data "authentik_flow" "default_source_enrollment" {
  slug = "default-source-enrollment"
}

data "authentik_flow" "default_source_authentication" {
  slug = "default-source-authentication"
}

# Reference existing Kubernetes service connection
data "authentik_service_connection_kubernetes" "local" {
  name = "Local Kubernetes Cluster"
}

# Get default signing certificate for RS256
data "authentik_certificate_key_pair" "default" {
  name = "authentik Self-signed Certificate"
}

# Get default OAuth2 scope mappings
data "authentik_property_mapping_provider_scope" "scope_email" {
  managed = "goauthentik.io/providers/oauth2/scope-email"
}

data "authentik_property_mapping_provider_scope" "scope_openid" {
  managed = "goauthentik.io/providers/oauth2/scope-openid" 
}

data "authentik_property_mapping_provider_scope" "scope_profile" {
  managed = "goauthentik.io/providers/oauth2/scope-profile"
}

