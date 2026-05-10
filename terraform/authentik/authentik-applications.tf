# Application for Cloudflare Access
resource "authentik_application" "cloudflare_access" {
  name              = "Cloudflare Access"
  slug              = "cloudflare-access"
  protocol_provider = authentik_provider_oauth2.cloudflare_access.id
  
  meta_description = "Cloudflare Access Integration"
  meta_publisher   = "Internal"
}

# Application for SillyTavern Proxy
resource "authentik_application" "sillytavern" {
  name              = "SillyTavern"
  slug              = "sillytavern"
  protocol_provider = authentik_provider_proxy.sillytavern_proxy.id
  
  meta_description = "SillyTavern LLM Frontend with Cloudflare SSO"
  meta_publisher   = "Internal"
  
  # Make it visible in the app launcher
  meta_launch_url = "https://st-test.home.ryougi.ca"
  
  # Icon (optional)
  meta_icon = "https://st.home.ryougi.ca/favicon.ico"
}