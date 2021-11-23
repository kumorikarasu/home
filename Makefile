.ONESHELL:
.PHONY: packer	

all: packer tfrun

tfplan:
	cd terraform
	terraform plan

tfapply:
	cd terraform
	terraform apply

tf:
	cd terraform
	terraform apply -auto-approve

# Only run this when there is a new image from ubuntu
packer-base:
	cd packer/ubuntu-2004
	packer build ubuntu-2004-proxmox.json

kube:
	kubectl apply -f kube/minecraft
	kubectl apply -f kube/satisfactory
