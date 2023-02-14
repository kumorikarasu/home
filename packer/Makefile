# Only run this when there is a new image from ubuntu
packer-os:
	./init-base-cloudimg.sh

packer-base:
	ssh root@pve.ryougi.ca "qm destroy 9001" || true
	packer init config.pkr.hcl
	sops exec-env ../terraform/proxmox/proxmox.enc.env 'packer build base.pkr.hcl' 

packer-bind:
	ssh root@pve.ryougi.ca "qm destroy 9011" || true
	sops exec-env ../terraform/proxmox/proxmox.enc.env 'packer build bind/ubuntu-bind.pkr.hcl' 

packer-docker:
	ssh root@pve.ryougi.ca "qm destroy 9010" || true
	sops exec-env ../terraform/proxmox/proxmox.enc.env 'packer build docker/ubuntu-docker.pkr.hcl' 
