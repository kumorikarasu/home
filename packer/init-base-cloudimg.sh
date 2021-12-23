#!/bin/bash

PROXMOX_URL="root@192.168.0.73"

#echo "scp $HOME/.ssh/id_rsa.pub $PROXMOX_URL:id_rsa.pub"
#scp $HOME/.ssh/id_rsa.pub $PROXMOX_URL:id_rsa.pub

VMID=9000

cat << EOF | ssh $PROXMOX_URL 'bash -s'

qm destroy $VMID

# Ubuntu 20.04 Cloud Image, run this for new images
# wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# create a new VM
qm create $VMID --memory 2048 --net0 virtio,bridge=vmbr0 --name "ubuntu-base"

# import the downloaded disk to local-lvm storage
qm importdisk $VMID focal-server-cloudimg-amd64.img local-lvm

# finally attach the new disk to the VM as scsi drive
qm set $VMID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-${VMID}-disk-1

# Cloud init cdrom
qm set $VMID --ide2 local-lvm:cloudinit

qm set $VMID --boot c --bootdisk scsi0

qm set $VMID --serial0 socket --vga serial0

qm resize $VMID scsi0 30G

qm set $VMID --ciuser kumori
qm set $VMID --sshkey id_rsa.pub

qm set $VMID --ipconfig0 ip=192.168.1.0/23,gw=192.168.0.1
 
qm template 9000
EOF
