# Call VPC module
module "vpc" {
  source       = "./modules/VPC"
  project_name = var.project_name
  region       = var.region
}

# Call EKS module
module "eks" {
  source       = "./modules/eks"
  project_name = var.project_name
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

# Call RDS module
module "rds" {
  source       = "./modules/rds"
  project_name = var.project_name
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_password  = var.db_password
}

# Call ALB module
module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}
