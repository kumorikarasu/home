resource "aws_iam_user" "argocd" {
  name = "argocd"

  tags = {
    terraform = true
  }
}

resource "aws_iam_access_key" "argocd" {
  user = aws_iam_user.argocd.name
}

resource "aws_iam_user_policy_attachment" "argocd" {
  user       = aws_iam_user.argocd.name
  policy_arn = aws_iam_policy.argocd.arn
}

resource "aws_iam_policy" "argocd" {
  name   = "argocd-decryptor-policy"
  policy = data.aws_iam_policy_document.argocd.json

  tags = {
    terraform = true
  }
}

data "aws_iam_policy_document" "argocd" {
  statement {
    sid = "ArgoCDDecryptor"
    actions = [
      "kms:RequestAlias",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    effect    = "Allow"
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "kms:ResourceAliases"
      values   = ["alias/Deployment"]
    }
  }
}

# External Secrets Operator IAM Resources
resource "aws_iam_user" "external_secrets_operator" {
  name = "external-secrets-operator"

  tags = {
    terraform = true
  }
}

resource "aws_iam_access_key" "external_secrets_operator" {
  user = aws_iam_user.external_secrets_operator.name
}

resource "aws_iam_user_policy_attachment" "external_secrets_operator" {
  user       = aws_iam_user.external_secrets_operator.name
  policy_arn = aws_iam_policy.external_secrets_operator.arn
}

resource "aws_iam_policy" "external_secrets_operator" {
  name   = "external-secrets-operator-policy"
  policy = data.aws_iam_policy_document.external_secrets_operator.json

  tags = {
    terraform = true
  }
}

data "aws_iam_policy_document" "external_secrets_operator" {
  statement {
    sid = "SSMParameterAccess"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    effect    = "Allow"
    resources = [
      "arn:aws:ssm:ca-central-1:*:parameter/home/k8s/*"
    ]
  }
}
