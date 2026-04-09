module "vpc" {
  source           = "./modules/vpc"
  vpc_subnet_az_id = var.subnet_az_ids
  vpc_cidr         = var.vpc_cidr
}

module "ecr" {
  source                = "./modules/ecr"
  scan_on_push          = var.scan_on_push
  image_tag_mutability  = var.image_tag_mutability
  repository_name       = var.repository_name
  allow_push_principals = var.allow_push_principals
  allow_pull_principals = var.allow_pull_principals
}