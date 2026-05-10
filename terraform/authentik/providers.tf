terraform {
  required_providers {
    authentik = {
      source = "goauthentik/authentik"
      version = "2025.6.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.8.4"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "authentik" {
  url   = var.authentik_url
  token = var.authentik_bootstrap_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token != "" ? var.cloudflare_api_token : null
}