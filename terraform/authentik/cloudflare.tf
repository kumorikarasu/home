# Cloudflare Zero Trust Access Identity Provider
resource "cloudflare_zero_trust_access_identity_provider" "authentik_oidc" {
  account_id = var.cloudflare_account_id
  name       = "Authentik OIDC"
  type       = "oidc"
  
  config = {
    client_id     = authentik_provider_oauth2.cloudflare_access.client_id
    client_secret = random_password.cloudflare_access_secret.result
    auth_url      = "${var.authentik_external_url}/application/o/authorize/"
    token_url     = "${var.authentik_external_url}/application/o/token/"
    certs_url     = "${var.authentik_external_url}/application/o/${authentik_application.cloudflare_access.slug}/jwks/"
    scopes        = ["openid", "email", "profile"]
    claims        = ["email", "preferred_username", "groups"]
    email_claim_name = "email"
  }
}