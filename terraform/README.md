# Home Terraform Code

## Setup TF Account
```
pveum role add TFServiceAccountRole -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit Pool.Allocate"
pveum user add terraform-service-account@pve
pveum aclmod / -user terraform-service-account@pve -role TFServiceAccountRole
pveum user token add terraform-service-account@pve token
```

Remember the token, it will only be displayed once export the result into env vars

```
export PM_API_TOKEN_ID=""
export PM_API_TOKEN_SECRET=""
```

# Template
Create the template from here. https://dev.to/mike1237/create-proxmox-cloud-init-templates-for-use-with-packer-193a
Just add `virt-customize --run-command 'systemctl start qemu-guest-agent' -a $IMG_NAME` to the virt steps
