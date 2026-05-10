init: 
	sops exec-env authentik.enc.env 'terraform init'

plan: 
	sops exec-env authentik.enc.env 'terraform plan'

import-stages:
	@echo "Importing default Authentik stages..."
	sops exec-env authentik.enc.env './scripts/import-default-stages.sh'

apply: import-stages
	@echo "Applying Terraform configuration..."
	sops exec-env authentik.enc.env 'terraform apply --auto-approve'
