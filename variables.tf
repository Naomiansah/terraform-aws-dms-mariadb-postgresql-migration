variable "aws_region" {
  description = "AWS region used for the migration project"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used when naming AWS resources"
  type        = string
  default     = "acme-dms-migration"
}

variable "vpc_cidr" {
  description = "CIDR block for the project VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the simulated on-premises source server"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet B"
  type        = string
  default     = "10.0.3.0/24"
}

variable "admin_ip" {
  description = "Your public IP address for SSH access"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for the simulated on-premises MySQL server"
  type        = string
  default     = "t3.micro"
}

variable "db_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "acmeretail"
}

variable "db_username" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "postgresadmin"
}



variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "dms_instance_class" {
  description = "Instance class for the DMS replication instance"
  type        = string
  default     = "dms.t3.small"
}