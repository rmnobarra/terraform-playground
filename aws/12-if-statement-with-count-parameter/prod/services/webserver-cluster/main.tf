provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "tf-state-crucial-starling"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.medium"
  min_size               = 2
  max_size               = 5
  enable_autoscaling     = true
  key_name               = var.key_name
  subnets_id             = var.subnets_id
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnets_id[0]
}

