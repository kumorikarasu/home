variable "host_node" {
  type    = string
  default = "pve"
}

variable "source_template" {
  type = string
  default = "ubuntu-cloudinit"
}

variable "template_name" {
  type    = string
  default = "ubuntu-bind"
}

variable "url" {
  type    = string
  default = "https://192.168.0.73:8006/api2/json"
}

variable "token" {
  type    = string
  default = "${env("PM_API_TOKEN_SECRET")}"
}

variable "username" {
  type    = string
  default = "${env("PM_API_TOKEN_ID")}"
}

source "proxmox-clone" "bind" {
  insecure_skip_tls_verify = true
  full_clone = false

  template_name = "${var.template_name}"
  vm_id         = 9011
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
  ssh_private_key_file = "/home/kumori/.ssh/id_rsa"
}

build {
  sources = ["source.proxmox-clone.bind"]

  provisioner "ansible" {
    playbook_file = "ansible/bind.yml"
  }

}
