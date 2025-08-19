output "rds_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "rds_port" {
  value = aws_rds_cluster.aurora.port
}
