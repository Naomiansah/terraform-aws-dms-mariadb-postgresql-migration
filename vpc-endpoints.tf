resource "aws_security_group" "secrets_manager_endpoint" {
  name        = "${var.project_name}-secrets-manager-endpoint-sg"
  description = "Allow HTTPS from DMS to Secrets Manager VPC endpoint"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTPS from DMS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.dms.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-secrets-manager-endpoint-sg"
  }
}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  security_group_ids = [
    aws_security_group.secrets_manager_endpoint.id
  ]

  tags = {
    Name = "${var.project_name}-secrets-manager-endpoint"
  }
}