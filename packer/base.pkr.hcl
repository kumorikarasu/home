variable "proxmox_host_node" {
  type    = string
  default = "pve"
}

variable "proxmox_token" {
  type      = string
  sensitive = true
  default = "${env("PM_API_TOKEN_SECRET")}"
}

variable "proxmox_username" {
  type    = string
  default = "${env("PM_API_TOKEN_ID")}"
}

source "proxmox-clone" "test-cloud-init" {
  insecure_skip_tls_verify = true
  full_clone = false

  template_name = "ubuntu-cloudinit"
  vm_id         = "9001"
  clone_vm      = "ubuntu-base"
  
  os              = "l26"
  cores           = "1"
  memory          = "512"
  scsi_controller = "virtio-scsi-pci"

  ssh_username         = "kumori"
  ssh_private_key_file = "/home/kumori/.ssh/id_rsa"
  qemu_agent = true

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  node          = "${var.proxmox_host_node}"
  username      = "${var.proxmox_username}"
  token         = "${var.proxmox_token}"
  proxmox_url   = "https://192.168.0.73:8006/api2/json"
}

build {
  sources = ["source.proxmox-clone.test-cloud-init"]

  provisioner "shell" {
    //expect_disconnect = true
    inline = ["sudo sed -i 's/#DNS=/DNS=192.168.1.1/g' /etc/systemd/resolved.conf && sudo service systemd-resolved restart && sudo cloud-init clean"]
    /*
    inline = [<<EOF
    sudo cloud-init clean \
    && echo "
      net.ipv6.conf.all.disable_ipv6 = 1 
      net.ipv6.conf.default.disable_ipv6 = 1 
      net.ipv6.conf.lo.disable_ipv6 = 1
    " | sudo tee -a /etc/sysctl.conf \
    && echo "
      #!/bin/bash
      # /etc/rc.local

      /etc/sysctl.d
      /etc/init.d/procps restart

      exit 0
    " | sudo tee -a /etc/rc.local \
    && sudo chmod +x /etc/rc.local \
    && sudo sysctl -p
    EOF
  ]
  */
  }
}
