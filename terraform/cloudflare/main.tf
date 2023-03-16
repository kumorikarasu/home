data "cloudflare_zone" "ryougi" {
  name = "ryougi.ca"
  account_id = "04ec7df88304960aa476d37e50378c81"
}

data "cloudflare_zone" "masterexploder" {
  name = "masterexploder.com"
  account_id = "04ec7df88304960aa476d37e50378c81"
}
