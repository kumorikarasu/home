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

We can use rancher to deploy kube on the kube nodes, have to look into a way for the kube nodes themselves on startup to query rancher and try to connect even without knowings its deployment token. Otherwise we have to set the token manually :(
