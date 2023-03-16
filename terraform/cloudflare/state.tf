terraform {
  cloud {
    organization = "kumorikarasu"

    workspaces {
      name = "home-cloudflare"
    }
  }
}
