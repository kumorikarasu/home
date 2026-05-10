# Get the default identification stage info
data "authentik_stage" "default_authentication_identification" {
  name = "default-authentication-identification"
}

# Modify the default identification stage to include Google OAuth
# This stage is automatically imported by the Makefile during 'make apply'
resource "authentik_stage_identification" "default_identification" {
  name                       = "default-authentication-identification"
  user_fields                = ["username", "email"]
  case_insensitive_matching  = true
  show_matched_user          = true
  show_source_labels         = true

  # Add Google OAuth source to the DEFAULT identification stage
  sources = [
    authentik_source_oauth.google.uuid
  ]
}
