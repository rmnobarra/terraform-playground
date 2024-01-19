terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}

provider "aws" {
  region = "us-east-2"
  alias  = "replica"
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  # Must be enabled to support replication
  backup_retention_period = 1

  subnets_id_primary = var.subnets_id_primary
  subnets_id_replica = var.subnets_id_replica
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  # Make this a replica of the primary
  replicate_source_db = module.mysql_primary.arn

  subnets_id_primary = var.subnets_id_primary
  subnets_id_replica = var.subnets_id_replica
}