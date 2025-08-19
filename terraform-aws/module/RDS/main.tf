# -------------------------------
# Aurora PostgreSQL Cluster
# -------------------------------
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.project_name}-aurora"
  engine                  = "aurora-postgresql"
  engine_version          = "15.4"
  database_name           = "appdb"
  master_username         = "admin"
  master_password         = var.db_password
  backup_retention_period = 7
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.rds.name
}

# -------------------------------
# Subnet Group for RDS
# -------------------------------
resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

# -------------------------------
# Security Group for RDS
# -------------------------------
resource "aws_security_group" "rds" {
  name   = "${var.project_name}-rds-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------------
# Aurora Reader Autoscaling
# -------------------------------
resource "aws_appautoscaling_target" "aurora_read" {
  max_capacity       = 5   # Maximum replicas
  min_capacity       = 1   # Minimum replicas
  resource_id        = "cluster:${aws_rds_cluster.aurora.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}

resource "aws_appautoscaling_policy" "aurora_read_policy" {
  name               = "${var.project_name}-aurora-read-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.aurora_read.resource_id
  scalable_dimension = aws_appautoscaling_target.aurora_read.scalable_dimension
  service_namespace  = aws_appautoscaling_target.aurora_read.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }
    target_value       = 70.0   # Scale out when average CPU > 70%
    scale_in_cooldown  = 300    # seconds
    scale_out_cooldown = 300
  }
}
