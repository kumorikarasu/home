resource "cloudflare_ruleset" "wrbgc_data_announcements_cache" {
  zone_id     = data.cloudflare_zone.wrbgc.id
  name        = "Cache WRBGC announcements JSON"
  description = "Cache data.wrbgc.ca/announcements.json at Cloudflare edge to reduce R2 Class B reads."
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules {
    description = "Cache announcements.json for 15 minutes"
    expression  = "(http.host eq \"data.wrbgc.ca\" and http.request.uri.path eq \"/announcements.json\")"
    action      = "set_cache_settings"
    enabled     = true

    action_parameters {
      cache = true

      edge_ttl {
        mode    = "override_origin"
        default = 900
      }

      browser_ttl {
        mode    = "override_origin"
        default = 900
      }
    }
  }
}
