variable "project_name" {
  description = "Project name for naming ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for ALB"
  type        = list(string)
}
