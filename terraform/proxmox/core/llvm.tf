resource "proxmox_vm_qemu" "llvm-vm" {
  count = 1
  name = "llvm${count.index + 1}"
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve2"

  # The destination resource pool for the new VM
  # pool = "kube"

  # provider fails if I try touch pools again
  lifecycle {
    ignore_changes = [
      pool,
      hostpci
    ]
  }

  # The template name to clone this vm from
  # This is currently setup manually as a template image
  clone = "ubuntu-base"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = 12
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 65536
  scsihw  = "virtio-scsi-pci"
  onboot  = "true"

  ipconfig0 = "ip=192.168.1.202/24,gw=192.168.1.1"

  # Setup the disk
  disk {
    size         = "128G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Unfortunatly, only root can access the GPU
  # So this has to be done manually
  #
  # # 2080
  # hostpci {
  #   host = "0000:09:00.0"
  #   rombar = 1
  #   pcie = 0
  # }

  # # 1070
  # hostpci {
  #   host = "0000:04:00.0"
  #   rombar = 1
  #   pcie = 0
  # }


  

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

}
