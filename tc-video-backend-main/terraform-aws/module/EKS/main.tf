module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.27"
  vpc_id          = aws_vpc.this.id
  subnet_ids      = aws_subnet.private[*].id

  # Managed Node Group (backed by ASG)
  eks_managed_node_groups = {
    workers = {
      desired_size   = 2
      min_size       = 2
      max_size       = 5
      instance_types = ["t3.medium"]

      labels = {
        role = "worker"
      }

      tags = {
        "k8s.io/cluster-autoscaler/enabled"                 = "true"
        "k8s.io/cluster-autoscaler/${var.project_name}-eks" = "owned"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true
}