variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "subnet_az_ids" {
  type        = list(string)
  description = "List of availability zone IDs for subnets"
}