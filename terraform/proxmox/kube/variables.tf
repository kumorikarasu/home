
variable "rancher_pass" {
  type = string
  default = "BootstrapRancherPassword"
}

variable "rancher_count" {
  type = number
  default = 0
}

variable "kube_nodes_count" {
  type = number
  default = 1
}

variable "kube_master_count" {
  type = number
  default = 2
}

variable "public_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOwoZ0u3t1QuHtElHSKaw2P6kUYF9cLnUcGjcKXErqZ kumori@DESKTOP-3N1AKAV"
}

