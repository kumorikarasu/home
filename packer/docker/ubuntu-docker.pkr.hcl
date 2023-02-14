variable "host_node" {
  type    = string
  default = "pve"
}

variable "source_template" {
  type = string
  default = "ubuntu-base"
}

variable "template_name" {
  type    = string
  default = "ubuntu-docker"
}

variable "url" {
  type    = string
  default = "https://192.168.1.10:8006/api2/json"
}

variable "token" {
  type    = string
  default = "${env("PM_API_TOKEN_SECRET")}"
}

variable "username" {
  type    = string
  default = "${env("PM_API_TOKEN_ID")}"
}

source "proxmox-clone" "docker" {
  insecure_skip_tls_verify = true
  full_clone = false

  template_name = "${var.template_name}"
  vm_id         = 9010
  clone_vm      = "${var.source_template}"
  
  os              = "l26"
  cores           = "1"
  memory          = "512"
  scsi_controller = "virtio-scsi-pci"
  qemu_agent      = true

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  node          = "${var.host_node}"
  username      = "${var.username}"
  token         = "${var.token}"
  proxmox_url   = "${var.url}"

  ssh_username         = "kumori"
  ssh_private_key_file = "/home/kumori/.ssh/id_ed25519"
}

build {
  sources = ["source.proxmox-clone.docker"]

  provisioner "shell" {
    inline         = ["sudo apt update && sudo apt install nfs-common -y && sudo apt install -y docker.io && sudo usermod -aG docker kumori"]
  }
}
