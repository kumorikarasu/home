# Authentik Terraform Configuration

This Terraform configuration sets up Authentik with:
- Cloudflare Access header authentication
- SillyTavern OAuth2/OIDC provider
- Proper application configuration

## Prerequisites

1. **Authentik deployed** via ArgoCD (from `argocd/app-apps/authentik-official/`)
2. **Authentik accessible** at `https://auth.home.ryougi.ca`
3. **API token generated** in Authentik admin interface

## Initial Setup

1. **Deploy Authentik first**:
   ```bash
   # Authentik will be deployed via ArgoCD
   # Wait for it to be accessible at https://auth.home.ryougi.ca
   ```

2. **Generate API token**:
   - Login to Authentik: `https://auth.home.ryougi.ca/if/admin/`
   - Go to Admin Interface → Directory → Tokens
   - Create token with "authentik Core: Can view/edit/create all objects"

3. **Configure secrets**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your API token
   ```

## Deployment

```bash
terraform init
terraform plan
terraform apply
```

## What This Creates

- **Cloudflare Headers Source**: Reads `Cf-Access-Authenticated-User-Email` headers
- **SillyTavern OAuth Provider**: OAuth2/OIDC provider for SillyTavern
- **Application Registration**: SillyTavern app in Authentik
- **Property Mappings**: Maps Cloudflare headers to user attributes

## SillyTavern Integration

After running Terraform, configure SillyTavern with the output values:
- Client ID: `sillytavern`
- Client Secret: (from Terraform output)
- Auth URL: `https://auth.home.ryougi.ca/application/o/authorize/`
- Token URL: `https://auth.home.ryougi.ca/application/o/token/`
- Userinfo URL: `https://auth.home.ryougi.ca/application/o/userinfo/`