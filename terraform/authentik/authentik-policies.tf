# Create a policy that allows authenticated users access to SillyTavern
resource "authentik_policy_expression" "sillytavern_access" {
  name = "SillyTavern Access Policy"
  expression = <<EOF
# Allow any authenticated user to access SillyTavern
return True
EOF
}

# Bind the policy to the SillyTavern application
resource "authentik_policy_binding" "sillytavern_access" {
  target = authentik_application.sillytavern.uuid
  policy = authentik_policy_expression.sillytavern_access.id
  order  = 0
}

# Note: Policy binding for proxy provider may not be needed - application-level policy should be sufficient