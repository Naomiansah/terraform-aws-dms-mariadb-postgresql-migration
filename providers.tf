provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "Acme-DMS-Migration"
      ManagedBy = "Terraform"
      Owner     = "Naomi"
    }
  }
}