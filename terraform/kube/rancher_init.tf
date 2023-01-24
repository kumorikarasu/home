
resource "null_resource" "rancher-exec" {
  count = length(proxmox_vm_qemu.rancher-vm.*)

  connection {
    host = proxmox_vm_qemu.rancher-vm[count.index].default_ipv4_address
    type = "ssh"
    user = "kumori"
    private_key = "${file("~/.ssh/id_ed25519")}"
  }

  provisioner "remote-exec" {
    inline = [
      format("sudo docker run -d --restart=unless-stopped -e CATTLE_BOOTSTRAP_PASSWORD=%s -p 80:80 -p 443:443 --privileged rancher/rancher:v2.6-head", var.rancher_pass)
    ]
  }

  triggers = {
    cluster_instance_ids = join(",", proxmox_vm_qemu.rancher-vm.*.id)
  }

  depends_on = [
    proxmox_vm_qemu.rancher-vm,
  ]
}

# We have to put a manual wait as it takes some time to install rancher. Rancher tends to crash once on startup, so we have to wait until after that crash to continue.
resource "time_sleep" "rancher_startup" {
  create_duration = "500s"

  depends_on = [ null_resource.rancher-exec ]
}

provider "rancher2" {
  alias = "bootstrap"

  api_url   = format("https://%s/", proxmox_vm_qemu.rancher-vm[0].default_ipv4_address)
  bootstrap = true
  insecure = true
}


# Create a new rancher2_bootstrap using bootstrap provider config
resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap

  initial_password = var.rancher_pass
  password = var.rancher_pass
  telemetry = true

  depends_on = [ time_sleep.rancher_startup ]
}

# Provider config for admin
provider "rancher2" {
  alias = "admin"

  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure = true
}

resource "rancher2_cluster" "home_kube" {
  provider = rancher2.admin

  name = "home-kube"
  description = "Home rancher2 k8s cluster"
  rke_config {
    network {
      plugin = "canal"
    }
    services {
      kube_api {
        audit_log {
          enabled = true
          configuration {
            max_age = 5
            max_backup = 5
            max_size = 100
            path = "-"
            format = "json"
            policy = file("auditlog_policy.yaml")
          }
        }
      }
    }
  }
}
