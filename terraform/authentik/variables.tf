variable "authentik_bootstrap_token" {
  description = "Authentik bootstrap token (same as in SOPS secrets)"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token with Zone:Read and Access:Edit permissions"
  type        = string
  sensitive   = true
  default     = ""
}

variable "authentik_url" {
  description = "Authentik instance URL (internal)"
  type        = string
  default     = "https://auth.home.ryougi.ca"
}

variable "authentik_external_url" {
  description = "Authentik instance URL (external, accessible by Cloudflare)"
  type        = string
  default     = "https://auth.ryougi.ca"
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for ryougi.ca"
  type        = string
  default     = ""
}


variable "cloudflare_team_domain" {
  description = "Cloudflare Zero Trust team domain"
  type        = string
  default     = "ryougi"
}


variable "admin_username" {
  description = "Admin username for Authentik"
  type        = string
  default     = "admin"
}

variable "admin_email" {
  description = "Admin email for Authentik"
  type        = string
  default     = "admin@home.ryougi.ca"
}

variable "admin_password" {
  description = "Admin password for Authentik"
  type        = string
  sensitive   = true
  default     = "changeme123!"
}

variable "google_client_id" {
  description = "Google OAuth Client ID"
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "Google OAuth Client Secret"
  type        = string
  sensitive   = true
}

# TODO: Add GitHub OAuth variables when ready
# variable "github_client_id" {
#   description = "GitHub OAuth App Client ID"
#   type        = string
#   sensitive   = true
# }

# variable "github_client_secret" {
#   description = "GitHub OAuth App Client Secret"
#   type        = string
#   sensitive   = true
# }