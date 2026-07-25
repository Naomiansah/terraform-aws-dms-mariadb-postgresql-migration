resource "aws_db_subnet_group" "postgres" {
  name = "${var.project_name}-db-subnets"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${var.project_name}-db-subnets"
  }
}

resource "aws_db_instance" "postgres" {

  identifier = "acme-postgres"

  engine         = "postgres"
  engine_version = "17"

  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true

  multi_az = true

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.postgres.name

  vpc_security_group_ids = [
    aws_security_group.rds_postgresql.id
  ]

  skip_final_snapshot = true

  backup_retention_period = 7

  deletion_protection = false

  tags = {
    Name = "Acme PostgreSQL"
  }
}