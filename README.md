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

# Image Map

9000 - Stock cloud-init image
9001 - Packer configured cloud-init image
9010 - Docker configured image
9011 - Bind configured image

# Some Notes on things
Shitty router + cloud-init + packer + proxmox = I hate my life. I've given up after weeks on trying to get a solid dhcp strategy functional. I'm just going with static IP for VM's

