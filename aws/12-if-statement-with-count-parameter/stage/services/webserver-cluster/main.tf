provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "tf-state-crucial-starling"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 3
  enable_autoscaling = false
  key_name           = var.key_name
  subnets_id         = var.subnets_id
  vpc_id             = var.vpc_id
  subnet_id          = var.subnets_id[0]
}