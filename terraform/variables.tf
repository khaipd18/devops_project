# Variables for Terraform configuration

#vpc configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "subnet_az_ids" {
  type        = list(string)
  description = "List of availability zone IDs for subnets"
}

#ecr configuration
variable "scan_on_push" {
  description = "Whether to enable image scanning on push"
  type        = bool
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "force_delete" {
  description = "Whether to force delete the repository even if it contains images"
  type        = bool
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
}

variable "allow_push_principals" {
  description = "List of principals allowed to push images to the repository"
  type        = list(string)
}

variable "allow_pull_principals" {
  description = "List of principals allowed to pull images from the repository"
  type        = list(string)
}

#github-oidc-role configuration
variable "github_oidc_role_name" {
  description = "The name of the IAM role to create for GitHub OIDC authentication"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository in the format 'owner/repo' that will be allowed to assume the role"
  type        = string
}