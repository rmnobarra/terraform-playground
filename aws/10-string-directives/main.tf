provider "aws" {
  region = "us-east-1"
}

#resource "aws_iam_user" "example" {
#  for_each = toset(var.user_names)
#  name     = each.value
#}