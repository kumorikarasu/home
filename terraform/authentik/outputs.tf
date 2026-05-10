# Output configuration for Cloudflare → Authentik → SillyTavern flow
output "sillytavern_proxy_config" {
  value = {
    proxy_url     = "${var.authentik_url}/outpost.goauthentik.io/"
    external_host = authentik_provider_proxy.sillytavern_proxy.external_host
    internal_host = authentik_provider_proxy.sillytavern_proxy.internal_host
    instructions  = <<-EOT
      CLOUDFLARE ACCESS → AUTHENTIK → SILLYTAVERN FLOW:
      
      1. Cloudflare Access forwards headers to Authentik proxy
      2. Authentik maps Cf-Access-Authenticated-User-Email to Remote-User
      3. SillyTavern reads Remote-User header for automatic login
      
      Cloudflare should proxy to: ${var.authentik_url}/outpost.goauthentik.io/
      Authentik forwards to: ${authentik_provider_proxy.sillytavern_proxy.internal_host}
    EOT
  }
}

# Output configuration for Cloudflare Access
output "cloudflare_access_config" {
  value = {
    client_id         = authentik_provider_oauth2.cloudflare_access.client_id
    client_secret     = random_password.cloudflare_access_secret.result
    authorize_url     = "${var.authentik_external_url}/application/o/authorize/"
    token_url         = "${var.authentik_external_url}/application/o/token/"
    userinfo_url      = "${var.authentik_external_url}/application/o/userinfo/"
    jwks_url          = "${var.authentik_external_url}/application/o/${authentik_application.cloudflare_access.slug}/jwks/"
    redirect_uri      = "https://${var.cloudflare_team_domain}.cloudflareaccess.com/cdn-cgi/access/callback"
    instructions      = "Configure these URLs in Cloudflare Zero Trust -> Settings -> Authentication -> Add OpenID Connect"
  }
  sensitive = true
}