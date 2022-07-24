resource "proxmox_vm_qemu" "haproxy-vm" {
  count = 1
  name = "haproxy${count.index + 1}"
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve"

  # The destination resource pool for the new VM
  # pool = "kube"

  # provider fails if I try touch pools again
  lifecycle {
    ignore_changes = [
      pool,
      ciuser,
      sshkeys,
    ]
  }

  # The template name to clone this vm from
  # This is currently setup manually as a template image
  clone = "ubuntu-docker"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = 2
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 2048
  scsihw  = "virtio-scsi-pci"
  onboot  = "true"

  ipconfig0 = "ip=192.168.1.200/24,gw=192.168.1.1"

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

}
