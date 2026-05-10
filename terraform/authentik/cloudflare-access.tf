# Cloudflare Access Application for Authentik OIDC endpoints (bypass protection)
resource "cloudflare_zero_trust_access_application" "authentik_oidc" {
  account_id = var.cloudflare_account_id
  name   = "Authentik OIDC Endpoints"
  domain = "auth.ryougi.ca/application/o/"
  type   = "self_hosted"
  
  session_duration = "24h"
  
  # CORS settings for OIDC
  cors_headers = {
    allow_all_headers = true
    allow_all_methods = true
    allow_all_origins = true
    max_age = 86400
  }
  
  # Bypass policies for OIDC endpoints
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.authentik_oidc_bypass.id
      precedence = 1
    }
  ]
}

# Policy to bypass all OIDC endpoints
resource "cloudflare_zero_trust_access_policy" "authentik_oidc_bypass" {
  account_id = var.cloudflare_account_id
  name = "OIDC Endpoints Bypass"
  decision = "bypass"

  include = [
    {
      everyone = {}
    }
  ]
}

# Cloudflare Access Application for Authentik admin interface
resource "cloudflare_zero_trust_access_application" "authentik_admin" {
  account_id = var.cloudflare_account_id
  name   = "Authentik"
  domain = "auth.ryougi.ca"
  type   = "self_hosted"
  
  # Match existing configuration
  app_launcher_visible = true
  auto_redirect_to_identity = false
  enable_binding_cookie = false
  http_only_cookie_attribute = false
  options_preflight_bypass = false
  session_duration = "24h"
  
  # Admin access policies
  policies = [
    {
      id = "47bd6240-56b1-4a70-8fdc-3685853a3cbc"
      precedence = 1
    },
    {
      id = cloudflare_zero_trust_access_policy.authentik_admin_allow.id
      precedence = 2
    }
  ]
}

# Policy to allow admin access to Authentik interface
resource "cloudflare_zero_trust_access_policy" "authentik_admin_allow" {
  account_id = var.cloudflare_account_id
  name = "Authentik Admin Access"
  decision = "allow"

  include = [
    {
      email = {
        email = var.admin_email
      }
    }
  ]
}