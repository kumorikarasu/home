# Google OAuth Source
resource "authentik_source_oauth" "google" {
  name                 = "Google"
  slug                 = "google"
  provider_type        = "google"
  
  consumer_key         = var.google_client_id
  consumer_secret      = var.google_client_secret
  
  # Additional Google OAuth scopes
  additional_scopes    = "email profile"
  
  # User matching settings
  user_matching_mode   = "email_link"
  
  # Enrollment flow
  enrollment_flow      = data.authentik_flow.default_source_enrollment.id
  authentication_flow  = data.authentik_flow.default_source_authentication.id
}

# GitHub OAuth Source (TODO: Add later if needed)
# resource "authentik_source_oauth" "github" {
#   name                 = "GitHub"
#   slug                 = "github"
#   provider_type        = "github"
#   
#   consumer_key         = var.github_client_id
#   consumer_secret      = var.github_client_secret
#   
#   # GitHub OAuth settings
#   authorization_url    = "https://github.com/login/oauth/authorize"
#   access_token_url     = "https://github.com/login/oauth/access_token"
#   profile_url          = "https://api.github.com/user"
#   
#   # Additional GitHub API endpoints for user info
#   additional_scopes    = ["user:email"]
#   
#   # User matching settings
#   user_matching_mode   = "email_link"
#   
#   # Enrollment flow
#   enrollment_flow      = data.authentik_flow.default_source_enrollment.id
#   authentication_flow  = data.authentik_flow.default_source_authentication.id
# }