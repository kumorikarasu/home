# Main Terraform configuration for Authentik with Cloudflare Zero Trust integration
# This configuration is split across multiple files for better organization:
#
# providers.tf      - Terraform and provider configuration
# variables.tf      - Input variables
# data.tf          - Data sources
# authentik-*.tf   - Authentik-specific resources
# cloudflare.tf    - Cloudflare Zero Trust configuration  
# outputs.tf       - Output values
#
# Usage:
# 1. Set environment variables using SOPS: source <(sops -d authentik.enc.env)
# 2. Run: make plan
# 3. Run: make apply