resource "aws_iam_openid_connect_provider" "github_core" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_subnet_az_id = var.subnet_az_ids
  vpc_cidr         = var.vpc_cidr
}

module "ecr" {
  source                = "./modules/ecr"
  scan_on_push          = var.scan_on_push
  force_delete          = var.force_delete
  image_tag_mutability  = var.image_tag_mutability
  repository_name       = var.repository_name
  allow_push_principals = var.allow_push_principals
  allow_pull_principals = var.allow_pull_principals
}

module "github_oidc_role" {
  source              = "./modules/github-oidc-role"
  role_name           = var.github_oidc_role_name
  github_repo         = var.github_repo
  oidc_provider_arn   = aws_iam_openid_connect_provider.github_core.arn
  ecr_repository_arns = [module.ecr.repository_arn]
}