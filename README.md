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

## Cluster Setup

```
# Install ArgoCD
helm install argocd ./argocd/argo --namespace argocd --create-namespace
# Setup AWS Credentials for ArgoCD
kubectl -n argocd create secret generic aws-token-secret --from-literal=AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --from-literal=AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

### Cloudflare
Create a secret for the cloudflare api token
```
kubectl create namespace system-certman
kubectl -n system-certman create secret generic cloudflare-api-token-secret --from-literal=api-token=${CLOUDFLARE_API_TOKEN}
```



# Image Map

9000 - Stock cloud-init image
9001 - Packer configured cloud-init image
9010 - Docker configured image
9011 - Bind configured image
