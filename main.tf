module "vpc" {
  source           = "./modules/vpc"
  vpc_subnet_az_id = var.subnet_az_ids
  vpc_cidr         = var.vpc_cidr
}