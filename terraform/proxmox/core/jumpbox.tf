resource "proxmox_vm_qemu" "jump-vm" {
  count = 1
  name = "jumpbox"
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
  clone = "ubuntu-base"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = 20
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 8192
  scsihw  = "virtio-scsi-pci"
  onboot  = "true"

  ipconfig0 = "ip=192.168.1.200/24,gw=192.168.1.1"

  # Setup the disk
  disk {
    size         = "96G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

}

resource "proxmox_vm_qemu" "vlan-vm" {
  name = "vlan"
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
  clone = "ubuntu-base"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = 20
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 8192
  scsihw  = "virtio-scsi-pci"
  onboot  = "true"

  ipconfig0 = "ip=192.168.2.2/24,gw=192.168.2.1"

  # Setup the disk
  disk {
    size         = "96G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"

    # VLAN ID:2:VMG1
    tag = 2
  }

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

}
