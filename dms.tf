resource "aws_dms_replication_subnet_group" "main" {
  replication_subnet_group_id          = "${var.project_name}-dms-subnets"
  replication_subnet_group_description = "Private subnets for the Acme DMS replication instance"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${var.project_name}-dms-subnets"
  }
}

resource "aws_dms_replication_instance" "main" {
  replication_instance_id    = "${var.project_name}-replication"
  replication_instance_class = var.dms_instance_class

  allocated_storage = 50

  replication_subnet_group_id = aws_dms_replication_subnet_group.main.id

  vpc_security_group_ids = [
    aws_security_group.dms.id
  ]

  publicly_accessible        = false
  multi_az                   = false
  auto_minor_version_upgrade = true
  apply_immediately          = true

  tags = {
    Name = "${var.project_name}-replication-instance"
  }
}
