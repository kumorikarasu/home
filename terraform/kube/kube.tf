

resource "proxmox_vm_qemu" "kube-master-vm" {
  depends_on = [ proxmox_vm_qemu.rancher-vm ]
  count = var.kube_master_count

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

  ipconfig0 = "ip=192.168.1.${count.index + 65}/24,gw=192.168.1.1"

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

  timeouts {
    create = "60m"
    delete = "2h"
  }

}

/*
resource "null_resource" "kube-exec-master" {
  count = length(proxmox_vm_qemu.kube-master-vm)

  connection {
    host = proxmox_vm_qemu.kube-master-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    inline = [
      //"${rancher2_cluster.home_kube.cluster_registration_token[0].node_command} --etcd --controlplane --node-name kube-master${count.index + 1} --address ${proxmox_vm_qemu.kube-master-vm[count.index].default_ipv4_address} --internal-address ${proxmox_vm_qemu.kube-master-vm[count.index].default_ipv4_address}"
    ]
  }
}
*/

resource "proxmox_vm_qemu" "kube-vm" {
  depends_on = [ proxmox_vm_qemu.kube-master-vm ]
  count = var.kube_nodes_count

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

  disk {
    size         = "64G"
    type         = "scsi"
    storage      = "local-lvm"
    ssd          = 0
    discard      = "on"
  }

  ipconfig0 = "ip=192.168.1.${count.index + 50}/24,gw=192.168.1.1"

  # Setup the network interface and assign a vlan tag: 256
  network {
    model  = "virtio"
    bridge = "vmbr0"
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


/*
resource "null_resource" "kube-exec" {
  count = length(proxmox_vm_qemu.kube-vm)

  connection {
    host = proxmox_vm_qemu.kube-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    inline = [
      "${rancher2_cluster.home_kube.cluster_registration_token[0].node_command} --etcd --controlplane --worker --node-name kube${count.index + 1} --address ${proxmox_vm_qemu.kube-vm[count.index].default_ipv4_address} --internal-address ${proxmox_vm_qemu.kube-vm[count.index].default_ipv4_address}"
    ]
  }
}
*/
