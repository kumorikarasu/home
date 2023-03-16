resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.ryougi.id
  name    = "@"
  value   = "99.251.172.104"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.ryougi.id
  name    = "www"
  value   = "99.251.172.104"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "pfsense" {
  zone_id = data.cloudflare_zone.ryougi.id
  name    = "pfsense"
  value   = "59c0e2b5-9ad1-4c29-86cf-9d3d175b5755.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "test" {
  zone_id = data.cloudflare_zone.ryougi.id
  name    = "test"
  value   = cloudflare_tunnel.test.cname
  type    = "CNAME"
  proxied = true
}
