data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "mysql_source" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.mysql_source.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = file("${path.module}/userdata/mysql.sh")

  root_block_device {
    encrypted   = true
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-mysql-source"
    Role = "Simulated-On-Premises-Database"
  }
}