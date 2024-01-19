terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

resource "aws_db_subnet_group" "subnetgroup_primary" {
  name       = "examplesubnetgroup_primary"
  subnet_ids = var.subnets_id_primary
  provider = aws.primary


  tags = {
    Name = "examplesubnetgroup"
  }
}

resource "aws_db_subnet_group" "subnetgroup_replica" {
  name       = "examplesubnetgroup_replica"
  subnet_ids = var.subnets_id_replica
  provider = aws.replica


  tags = {
    Name = "examplesubnetgroup"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"

  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.subnetgroup_primary.name

  backup_retention_period = var.backup_retention_period

  replicate_source_db = var.replicate_source_db

  engine = var.replicate_source_db == null ? "mysql" : null

  db_name = var.replicate_source_db == null ? var.db_name : null

  username = var.replicate_source_db == null ? var.db_username : null

  password = var.replicate_source_db == null ? var.db_password : null

}
