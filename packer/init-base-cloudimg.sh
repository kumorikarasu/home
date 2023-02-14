#!/bin/bash

PROXMOX_URL="root@192.168.1.10"

# Ubuntu 22.04 Cloud Image
UBUNTU_VER="jammy"
UBUNTU_V="22.04"

#echo "scp $HOME/.ssh/id_rsa.pub $PROXMOX_URL:id_rsa.pub"
#scp $HOME/.ssh/id_rsa.pub $PROXMOX_URL:id_rsa.pub

VMID=9000

cat << EOF | ssh $PROXMOX_URL 'bash -s'

qm destroy $VMID

# Download the image and install qemu-guest-agent
rm -f ${UBUNTU_VER}-server-cloudimg-amd64.img

if [ ! -f ${UBUNTU_VER}-server-cloudimg-amd64.img ]; then
  # virt-customize is used to install qemu-guest-agent without booting the VM
  apt install libguestfs-tools -y

  wget https://cloud-images.ubuntu.com/minimal/releases/${UBUNTU_VER}/release/ubuntu-${UBUNTU_V}-minimal-cloudimg-amd64.img
  mv ubuntu-${UBUNTU_V}-minimal-cloudimg-amd64.img ${UBUNTU_VER}-server-cloudimg-amd64.img

  virt-customize -a ${UBUNTU_VER}-server-cloudimg-amd64.img --install qemu-guest-agent
fi

# create a new VM
qm create $VMID --memory 2048 --net0 virtio,bridge=vmbr0 --name "ubuntu-base"

# import the downloaded disk to local-lvm storage
qm importdisk $VMID ${UBUNTU_VER}-server-cloudimg-amd64.img local-lvm

# finally attach the new disk to the VM as scsi drive
qm set $VMID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-${VMID}-disk-1

# Cloud init cdrom
qm set $VMID --ide2 local-lvm:cloudinit

qm set $VMID --boot c --bootdisk scsi0

qm set $VMID --serial0 socket --vga serial0

qm resize $VMID scsi0 32G

qm set $VMID --ciuser kumori
qm set $VMID --sshkey id_rsa.pub

qm set $VMID --ipconfig0 ip=dhcp
qm set $VMID --agent enabled=1

qm template 9000
EOF
