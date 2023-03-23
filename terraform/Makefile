
plan: tfplan

awsinit:
	cd aws
	terraform init

awsplan:
	cd aws
	tflint
	tfsec
	terraform init

base:
	cd terraform/base
	terraform init
	terraform apply

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply
