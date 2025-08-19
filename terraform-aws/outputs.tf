# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnets IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnets IDs"
  value       = module.vpc.private_subnets
}

# EKS Outputs
output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group for EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "eks_node_group_arn" {
  description = "Node group ARN"
  value       = module.eks.node_group_arn
}

# RDS Outputs
output "rds_endpoint" {
  description = "Aurora Serverless v2 endpoint"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "Aurora Serverless v2 port"
  value       = module.rds.rds_port
}

# ALB Outputs
output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}
