
variable "rancher_pass" {
  type = string
  default = "BootstrapRancherPassword"
}

variable "rancher_count" {
  type = number
  default = 1
}

variable "kube_nodes_count" {
  type = number
  default = 2
}

variable "kube_master_count" {
  type = number
  default = 2
}

