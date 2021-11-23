

resource "proxmox_vm_qemu" "kube-master-vm" {
  count = 1
  name = "kube-master${count.index + 1}"
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
  cores   = 4 
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 4096
  scsihw  = "virtio-scsi-pci"

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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaLvJnJHpOtJJWsz1v0sg3eid6FxjZaHfqEN5/FQnldwOXtYKeI4M2YEBII4BSHnhr5ZpreFEvuVJuxh8qpzLzF8r7A0FAmeEEh6uBc+y9lLhdMaqTEBBpTFArarrcfKzKm+NBYYvVXAsoeY/8OwRj3+WlCLQWT6tT60w3SN6dwtQgaJa1lTH43umCXz+bwcI5VqJnkEFj3Z9wLoyEVOrQpwQaj5ELW1XDVhE0EZlyxFFzGoQVd6iCRzPmRhndgi3/L5A+dNS6SlUoYMhW+JyE6M3UHHqlYfJ0aOR6Pw5QmZcNXK2WwWU+wepW2Ktod6K0EcrRseoavo5dR0/FlPc1 kumori@DESKTOP-3N1AKAV
  EOF
}

resource "null_resource" "kube-exec-master" {
  count = length(proxmox_vm_qemu.kube-master-vm)

  connection {
    host = proxmox_vm_qemu.kube-master-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.6.2 --server https://192.168.0.78 --token fjzmjclmzzf9nk5cdhvcdldzq66v2fw944297g4jzv2jd8g99l499w --ca-checksum f008fbf93dda11077c7353aca7407e878d179bca0169dfd41501b566cb1998c4 --etcd --controlplane --node-name kube-master${count.index + 1}"
    ]
  }
}

resource "proxmox_vm_qemu" "kube-vm" {
  count = 2
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
  clone = "ubuntu-docker"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = 10 
  sockets = 2
  vcpus   = 0
  cpu     = "host"
  memory  = 65536
  scsihw  = "virtio-scsi-pci"

  # Setup the disk
  disk {
    size         = "32G"
    type         = "scsi"
    storage      = "UNRAID"
    ssd          = 0
    discard      = "on"
  }

  ipconfig0 = "ip=dhcp"

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

resource "null_resource" "kube-exec" {
  count = length(proxmox_vm_qemu.kube-vm)

  connection {
    host = proxmox_vm_qemu.kube-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.6.2 --server https://192.168.0.78 --token fjzmjclmzzf9nk5cdhvcdldzq66v2fw944297g4jzv2jd8g99l499w --ca-checksum f008fbf93dda11077c7353aca7407e878d179bca0169dfd41501b566cb1998c4 --etcd --controlplane --worker --node-name kube${count.index + 1}"
    ]
  }
}
