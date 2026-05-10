# Create a group for Cloudflare users
resource "authentik_group" "cloudflare_users" {
  name         = "Cloudflare Users"
  is_superuser = true
  
  attributes = jsonencode({
    cloudflare_access = true
  })
}

# Create admin user
resource "authentik_user" "admin" {
  username  = var.admin_username
  name      = "Administrator"
  email     = var.admin_email
  is_active = true
  password  = var.admin_password
  type      = "internal"
  groups    = [authentik_group.cloudflare_users.id]
}