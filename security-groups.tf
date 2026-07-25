resource "aws_security_group" "mysql_source" {
  name        = "${var.project_name}-mysql-source-sg"
  description = "Allow SSH access and MySQL access from DMS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from administrator"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  ingress {
    description     = "MySQL from DMS"
    from_port       = 3306
    to_port         = 3306
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
    Name = "${var.project_name}-mysql-source-sg"
  }
}

resource "aws_security_group" "rds_postgresql" {
  name        = "${var.project_name}-postgresql-sg"
  description = "Allow PostgreSQL access from DMS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from DMS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.dms.id]
  }

  ingress {
    description     = "PostgreSQL from MariaDB EC2 for verification"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.mysql_source.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-postgresql-sg"
  }
}

resource "aws_security_group" "dms" {
  name        = "${var.project_name}-dms-sg"
  description = "Security group for AWS DMS"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-dms-sg"
  }
}

