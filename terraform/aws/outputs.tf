output "external_secrets_operator_access_key_id" {
  value = aws_iam_access_key.external_secrets_operator.id
}

output "external_secrets_operator_secret_access_key" {
  value     = aws_iam_access_key.external_secrets_operator.secret
  sensitive = true
}