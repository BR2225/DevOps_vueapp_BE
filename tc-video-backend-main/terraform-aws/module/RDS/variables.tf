variable "project_name" {
  description = "Project name for naming RDS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "db_password" {
  description = "Master password for RDS cluster"
  type        = string
  sensitive   = true
}
