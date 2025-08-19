variable "project_name" {
  description = "Project name for naming EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS cluster will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets for EKS nodes"
  type        = list(string)
}
