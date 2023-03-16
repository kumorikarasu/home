resource "cloudflare_tunnel" "test" {
  account_id = var.account_id
  name       = "Test2"
  secret     = var.tunnel_secret
}

resource "cloudflare_tunnel_config" "test_config" {
  account_id = var.account_id
  tunnel_id = cloudflare_tunnel.test.id

  config {
    ingress_rule {
      hostname = "test.ryougi.ca"
      service = "https://localhost:80"
    }

    ingress_rule {
      service = "https://localhost:80"
    }
  }
}
