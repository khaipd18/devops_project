# This Terraform module creates an AWS IAM role that can be assumed by GitHub Actions using OpenID Connect (OIDC).
# The role will have permissions to access specified ECR repositories, allowing GitHub Actions workflows to authenticate and interact with AWS resources securely.
data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # The "sub" claim in the OIDC token must match the specified GitHub repository
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}

# This policy grants permissions to access the specified ECR repositories
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

# The policy document for ECR permissions is defined separately to keep the role definition clean and focused on the trust relationship.
data "aws_iam_policy_document" "ecr_permissions" {
  # Common permissions for Docker to login (Resource is required to be "*")
  statement {
    sid       = "GetAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
  # Pull and push permissions for the specified ECR repositories
  statement {
    sid    = "AllowPushPull"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = var.ecr_repository_arns
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.role_name}-ECR-Policy"
  description = "Permissions for GitHub Actions to manage ECR images"
  policy      = data.aws_iam_policy_document.ecr_permissions.json
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}