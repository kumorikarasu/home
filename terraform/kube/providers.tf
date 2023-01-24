terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.25.0"
    }
  }
}


provider "proxmox" {
  # TODO: DNS Server
  # pm_api_token_id = PM_API_TOKEN_ID env
  # pm_api_token_secret = PM_API_TOKEN_SECRET env

  pm_api_url      = "https://192.168.1.10:8006/api2/json"
  pm_tls_insecure = true
}

provider "dns" {
  update {
    server        = "192.168.1.2"
    key_name      = "terraformKey."
    key_algorithm = "hmac-md5"
    key_secret    = "QmluZFN1cGVyQ29vbE5vdFZlcnlTZWN1cmVQYXNzCg=="
  }
}
