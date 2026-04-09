variable "vpc_cidr" {
  default     = "10.18.0.0/16"
  description = "CIDR block for the VPC"
}

variable "subnet_az_ids" {
  default     = ["apse1-az1", "apse1-az2"]
  type        = list(string)
  description = "List of availability zone IDs for subnets"
}