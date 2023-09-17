
resource "proxmox_vm_qemu" "kube-master-vm" {
  name = "kube-master-1"
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
  cores   = 4 
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 4096
  scsihw  = "virtio-scsi-pci"

  ipconfig0 = "ip=192.168.16.22/20,gw=192.168.16.1"

  # Setup the disk
  disk {
    size         = "32G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  #VLAN ID
  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = 2
  }

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

  timeouts {
    create = "60m"
    delete = "2h"
  }

}

resource "proxmox_vm_qemu" "kube-vm" {
  count = var.kube_nodes_count

  name = "kube-1"
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
  sockets = 2
  vcpus   = 0
  cpu     = "host"
  memory  = 98304
  scsihw  = "virtio-scsi-pci"

  disk {
    size         = "64G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  ipconfig0 = "ip=192.168.16.20/20,gw=192.168.16.1"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = 2
  }

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

  timeouts {
    create = "60m"
    delete = "2h"
  }
}

resource "proxmox_vm_qemu" "kube-pve2-vm" {
  name = "kube-2"
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve2"

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
  cores   = 6
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 32768
  scsihw  = "virtio-scsi-pci"

  disk {
    size         = "64G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  ipconfig0 = "ip=192.168.16.21/20,gw=192.168.16.1"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = 2
  }

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

  timeouts {
    create = "10m"
    delete = "10m"
  }
}
