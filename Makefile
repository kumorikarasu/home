.ONESHELL:
.PHONY: packer	

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

# Bind servers will be static on 192.168.1.254 (VM) and 1.253 (PI)
ansible-bind:
	ansible-playbook ansible/bind.yml -i 192.168.1.254,
