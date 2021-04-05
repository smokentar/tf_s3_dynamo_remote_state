output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket storing state"
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for locking"
  value = aws_dynamodb_table.terraform_locks.name
}
