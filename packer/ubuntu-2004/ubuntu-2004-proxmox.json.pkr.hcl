
variable "common_version" {
  type    = string
  default = "1.0.0"
}

variable "cpus" {
  type    = string
  default = "8"
}

variable "disk_size" {
  type    = string
  default = "30G"
}

variable "node_name" {
  type    = string
  default = "pve"
}

variable "ram" {
  type    = string
  default = "8192"
}

variable "template_description" {
  type    = string
  default = "Ubuntu 20.04 x86_64 template built with packer"
}

variable "token" {
  type    = string
  default = "${env("PM_API_TOKEN_SECRET")}"
}

variable "username" {
  type    = string
  default = "${env("PM_API_TOKEN_ID")}"
}

variable "vm_id" {
  type    = string
  default = "1000"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-2004"
}

source "proxmox" "base_image" {
  insecure_skip_tls_verify = true

  vm_id                = "${var.vm_id}"
  vm_name              = "${var.vm_name}"

  cores                   = "${var.cpus}"
  memory                   = "${var.ram}"

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }

  scsi_controller      = "virtio-scsi-pci"
  disks {
    disk_size         = "${var.disk_size}"
    format            = "qcow2"
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm-thin"
    type              = "scsi"
  }

  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://192.168.0.13:5000/", "<enter><wait>"]
  boot_wait               = "5s"
  
  http_directory           = "http"
  http_port_max            = 5000
  http_port_min            = 5000

  iso_urls                 = ["ubuntu-20.04.3-live-server-amd64.iso", "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"]
  iso_checksum             = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_storage_pool         = "local"

  os                   = "l26"
  node                 = "${var.node_name}"
  proxmox_url          = "https://192.168.0.73:8006/api2/json"
  template_description = "${var.template_description}"
  username             = "${var.username}"
  token                = "${var.token}"
  unmount_iso          = true

  ssh_username         = "kumori"
  ssh_private_key_file = "/home/kumori/.ssh/id_rsa"
  ssh_timeout          = "300m"
}

build {
  sources = ["source.proxmox.base_image"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }
}
