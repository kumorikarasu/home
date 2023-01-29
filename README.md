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
# Setup AWS credentials for ArgoCD
# All other credentials required are stored in the git repo under secrets.enc.yaml files
kubectl -n argocd create secret generic aws-token-secret --from-literal=AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --from-literal=AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

KMS Key was created manually in AWS, do not want that to ever be destroyed

# Image Map

9000 - Stock cloud-init image
9001 - Packer configured cloud-init image
9010 - Docker configured image
9011 - Bind configured image
