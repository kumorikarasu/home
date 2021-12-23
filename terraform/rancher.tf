resource "proxmox_vm_qemu" "rancher-vm" {
  count = 1
  name = "racher${count.index + 1}"
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

  ipconfig0 = "ip=192.168.1.${count.index + 10}/23,gw=192.168.0.1"

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

  ciuser  = "kumori"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaLvJnJHpOtJJWsz1v0sg3eid6FxjZaHfqEN5/FQnldwOXtYKeI4M2YEBII4BSHnhr5ZpreFEvuVJuxh8qpzLzF8r7A0FAmeEEh6uBc+y9lLhdMaqTEBBpTFArarrcfKzKm+NBYYvVXAsoeY/8OwRj3+WlCLQWT6tT60w3SN6dwtQgaJa1lTH43umCXz+bwcI5VqJnkEFj3Z9wLoyEVOrQpwQaj5ELW1XDVhE0EZlyxFFzGoQVd6iCRzPmRhndgi3/L5A+dNS6SlUoYMhW+JyE6M3UHHqlYfJ0aOR6Pw5QmZcNXK2WwWU+wepW2Ktod6K0EcrRseoavo5dR0/FlPc1 kumori@DESKTOP-3N1AKAV
  EOF
}

resource "null_resource" "racher-exec" {
  count = 1

  connection {
    host = proxmox_vm_qemu.rancher-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher"
    ]
  }

  triggers = {
    cluster_instance_ids = join(",", proxmox_vm_qemu.rancher-vm.*)
  }

  depends_on = [
    proxmox_vm_qemu.rancher-vm,
  ]
}

resource "dns_a_record_set" "rancher" {
  count = length(proxmox_vm_qemu.rancher-vm)
  zone = "ryougi.io."
  name = "rancher${count.index + 1}"
  addresses = [
    proxmox_vm_qemu.rancher-vm[count.index].default_ipv4_address,
  ]
  ttl = 300
}
