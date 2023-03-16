data "cloudflare_zone" "ryougi" {
  name = "ryougi.ca"
  account_id = var.account_id
}

data "cloudflare_zone" "masterexploder" {
  name = "masterexploder.com"
  account_id = var.account_id
}
