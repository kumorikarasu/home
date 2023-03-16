terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.0.0"
    }
  }
}

provider "cloudflare" {
  # Cloudflare API token
  # https://www.terraform.io/docs/providers/cloudflare/index.html#api-token
  # https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys
  #
  # using CLOUDFLARE_API_TOKEN environment variable
}
