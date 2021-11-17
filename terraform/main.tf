terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.1"
    }
  }
}

provider "proxmox" {
  # TODO: DNS Server
  # pm_api_token_id = PM_API_TOKEN_ID env
  # pm_api_token_secret = PM_API_TOKEN_SECRET env

  pm_api_url      = "https://192.168.0.73:8006/api2/json"
  pm_user         = "TFServiceAccount"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "cloudinit-test" {
  count = 3
  name = "kube${count.index + 1}"
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve"

  # The destination resource pool for the new VM
  # pool = "kube"

  # provider fails if I try touch pools again
  lifecycle {
    ignore_changes = [
      pool
    ]
  }

  # The template name to clone this vm from
  # This is currently setup manually as a template image
  clone = "ubuntu2004-cloud"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "other"
  ciuser  = "kumori"
  cores   = 2
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 2048
  scsihw  = "virtio-scsi-pci"

  # Setup the disk
  disk {
    size         = "32G"
    type         = "scsi"
    storage      = "UNRAID"
    ssd          = 0
    discard      = "on"
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  # I could not get dhcp to work, every single VM had the same IP
  # I'm going to put that on the bad router I have for now
  ipconfig0 = format("%s%02d%s", "ip=192.168.1.1", count.index, "/23,gw=192.168.0.1,ip6=dhcp")

  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaLvJnJHpOtJJWsz1v0sg3eid6FxjZaHfqEN5/FQnldwOXtYKeI4M2YEBII4BSHnhr5ZpreFEvuVJuxh8qpzLzF8r7A0FAmeEEh6uBc+y9lLhdMaqTEBBpTFArarrcfKzKm+NBYYvVXAsoeY/8OwRj3+WlCLQWT6tT60w3SN6dwtQgaJa1lTH43umCXz+bwcI5VqJnkEFj3Z9wLoyEVOrQpwQaj5ELW1XDVhE0EZlyxFFzGoQVd6iCRzPmRhndgi3/L5A+dNS6SlUoYMhW+JyE6M3UHHqlYfJ0aOR6Pw5QmZcNXK2WwWU+wepW2Ktod6K0EcrRseoavo5dR0/FlPc1 kumori@DESKTOP-3N1AKAV
  EOF
}

