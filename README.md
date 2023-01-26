# Home System

Code for setting up my home systems and deployments

# Proxmox
This assumes proxmos is installed, a service account is created, and it contains the NAS as a storage pool. Everything else should be 100% automated.

# Terraform/Packer Credentials
Environment Variables as follows
```
PM_API_TOKEN_ID=""
PM_API_TOKEN_SECRET=""
```

# Kubernetes

## Cloudflare
Create a secret for the cloudflare api token
```
kubectl create namespace system-cert-manager
kubectl -n system-cert-manager create secret generic cloudflare-api-token-secret --from-literal=api-token=${CLOUDFLARE_API_TOKEN}
```


# Image Map

9000 - Stock cloud-init image
9001 - Packer configured cloud-init image
9010 - Docker configured image
9011 - Bind configured image
