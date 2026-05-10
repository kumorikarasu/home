# Our custom authentication flow is already created in authentik-flows.tf
# We just need to make sure applications use it, which we've already done in the providers
# No brand management needed - apps will use our custom flow via their authentication_flow setting