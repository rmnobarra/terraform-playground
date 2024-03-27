provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "example" {
  name       = "examplesubnetgroup-prod"
  subnet_ids = var.subnets_id

  tags = {
    Name = "examplesubnetgroup"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix    = "terraform-up-and-running-prod"
  engine               = "mysql"
  allocated_storage    = 10
  instance_class       = "db.t2.micro"
  skip_final_snapshot  = true
  db_name              = "example_database"
  db_subnet_group_name = aws_db_subnet_group.example.name

  # How should we set the username and password?
  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "tf-state-crucial-starling"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "tf-state-locking-crucial-starling"
    encrypt        = true
  }
}