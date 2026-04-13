output "output_vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "output_vpc_cidr" {
  value       = aws_vpc.vpc.cidr_block
  description = "VPC CIDR Block"
}

output "private_subnet_ids" {
  value       = module.subnet.output_private_subnet_ids
  description = "Private Subnet IDs"
}

output "public_subnet_ids" {
  value       = module.subnet.output_public_subnet_ids
  description = "Public Subnet IDs"
}