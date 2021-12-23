.ONESHELL:
.PHONY: packer	

all: packer tfrun

plan: tfplan

tfbase:
	cd terraform/base
	terraform init
	terraform apply

tfinit:
	cd terraform
	terraform init

tfplan:
	cd terraform
	terraform plan

tfapply:
	cd terraform
	terraform apply

deploy: tf

tf:
	cd terraform
	terraform apply -auto-approve

# Only run this when there is a new image from ubuntu
packer-os:
	cd packer
	./init-base-cloudimg.sh

packer-base:
	ssh root@192.168.0.73 "qm destroy 9001"
	packer build packer/base.pkr.hcl

packer-bind:
	ssh root@192.168.0.73 "qm destroy 9011"
	packer build packer/bind/ubuntu-bind.pkr.hcl

packer-docker:
	ssh root@192.168.0.73 "qm destroy 9010"
	packer build packer/docker/ubuntu-docker.pkr.hcl

kube:
	kubectl apply -f kube/minecraft
	kubectl apply -f kube/satisfactory

# Bind servers will be static on 192.168.1.1 and 1.2 when I get a pi
ansible-bind:
	ansible-playbook ansible/bind.yml -i 192.168.1.1,

