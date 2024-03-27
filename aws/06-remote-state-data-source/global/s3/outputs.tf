output "dynanodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "tfstate_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}