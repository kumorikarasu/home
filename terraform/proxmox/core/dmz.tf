resource "proxmox_vm_qemu" "haproxy-vm" {
  count = 1
  name = "dmz-haproxy${count.index + 1}"
  desc = "DMZ VM for cloudflare/public routing"

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
  clone = "ubuntu"

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

  ipconfig0 = "ip=192.168.1.254/24,gw=192.168.1.1"

  # Setup the disk
  disk {
    size         = "32G"
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

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV
  EOF

}
