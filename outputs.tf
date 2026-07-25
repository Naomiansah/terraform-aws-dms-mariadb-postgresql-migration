output "mysql_source_public_ip" {
  description = "Public IP of the simulated on-premises MySQL server"
  value       = aws_instance.mysql_source.public_ip
}

output "mysql_source_private_ip" {
  description = "Private IP of the MySQL source server"
  value       = aws_instance.mysql_source.private_ip
}

output "postgres_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "postgres_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgres.port
}

output "dms_replication_instance_arn" {
  description = "ARN of the DMS replication instance"
  value       = aws_dms_replication_instance.main.replication_instance_arn
}
output "postgres_master_secret_arn" {
  description = "ARN of the RDS-managed master credentials secret"
  value       = aws_db_instance.postgres.master_user_secret[0].secret_arn
}