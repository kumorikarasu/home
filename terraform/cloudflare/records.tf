# Add a record to the domain
resource "cloudflare_record" "pfsense" {
  zone_id = data.cloudflare_zone.ryougi.id
  name    = "pfsense"
  value   = "59c0e2b5-9ad1-4c29-86cf-9d3d175b5755.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
