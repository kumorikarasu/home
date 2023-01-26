terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.1"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "proxmox" {
  # TODO: DNS Server
  # pm_api_token_id = PM_API_TOKEN_ID env
  # pm_api_token_secret = PM_API_TOKEN_SECRET env

  pm_api_url      = "https://192.168.1.10:8006/api2/json"
  pm_user         = "TFServiceAccount"
  pm_tls_insecure = true
}
