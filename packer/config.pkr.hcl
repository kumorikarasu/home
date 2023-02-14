packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      version = ">= 1.0.3"
    }
  }
}
