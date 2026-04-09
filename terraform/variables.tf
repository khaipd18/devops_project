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
