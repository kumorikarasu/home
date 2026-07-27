# WRBGC is a static Vite/Svelte site deployed to Cloudflare Pages.
# Terraform owns the persistent Cloudflare objects here; CI/wrangler should upload
# built artifacts to this direct-upload Pages project.
resource "cloudflare_pages_project" "wrbgc" {
  account_id        = var.account_id
  name              = "wrbgc"
  production_branch = "main"

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
    root_dir        = ""
  }
}

resource "cloudflare_pages_domain" "wrbgc_apex" {
  account_id   = var.account_id
  project_name = cloudflare_pages_project.wrbgc.name
  domain       = "wrbgc.ca"
}

resource "cloudflare_pages_domain" "wrbgc_www" {
  account_id   = var.account_id
  project_name = cloudflare_pages_project.wrbgc.name
  domain       = "www.wrbgc.ca"
}

resource "cloudflare_record" "wrbgc_apex_pages" {
  zone_id         = data.cloudflare_zone.wrbgc.id
  name            = "@"
  value           = cloudflare_pages_project.wrbgc.subdomain
  type            = "CNAME"
  proxied         = true
  allow_overwrite = true
}

resource "cloudflare_record" "wrbgc_www_pages" {
  zone_id         = data.cloudflare_zone.wrbgc.id
  name            = "www"
  value           = cloudflare_pages_project.wrbgc.subdomain
  type            = "CNAME"
  proxied         = true
  allow_overwrite = true
}
