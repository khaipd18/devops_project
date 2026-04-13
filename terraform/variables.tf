# Variables for Terraform configuration

#vpc configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "az_ids" {
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

#eks configuration
# EKS cluster variables
variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "eks_vpc_config_override" {
  type = object({
    endpoint_private_access = optional(bool)
    endpoint_public_access  = optional(bool)
    public_access_cidrs     = optional(list(string))
  })
}

variable "eks_k8s_version" {
  description = "The Kubernetes version to use for the EKS cluster."
  type        = string
}

#eks node group variables
variable "eks_node_group_instance_type" {
  description = "The EC2 instance type to use for the EKS node group."
  type        = list(string)
  default     = ["t2.micro", "t2.medium", "t2.large"]
}

variable "eks_node_group_ami_type" {
  description = "The AMI type to use for the EKS node group."
  type        = string
}

variable "eks_node_group_capacity_type" {
  description = "The capacity type to use for the EKS node group (e.g., ON_DEMAND or SPOT)."
  type        = string
}

variable "eks_node_group_disk_size" {
  description = "The disk size (in GiB) to use for the EKS node group."
  type        = number
}

variable "eks_node_group_scaling_config" {
  description = "The scaling configuration for the EKS node group."
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

#eks addon variables
variable "eks_cni_version" {
  description = "The version of the VPC CNI plugin to use for the EKS cluster."
  type        = string
}

variable "eks_coredns_version" {
  description = "The version of the CoreDNS addon to use for the EKS cluster."
  type        = string
}

variable "eks_kube_proxy_version" {
  description = "The version of the kube-proxy addon to use for the EKS cluster."
  type        = string
}

