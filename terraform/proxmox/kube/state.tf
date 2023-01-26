terraform {
  cloud {
    organization = "kumorikarasu"

    workspaces {
      name = "home-kube"
    }
  }
}
