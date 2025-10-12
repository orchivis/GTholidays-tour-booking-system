output "state_bucket_name" {
  value       = aws_s3_bucket.tf_state.bucket
  description = "The S3 bucket name used for Terraform state"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tf_lock.name
  description = "The DynamoDB table name used for Terraform state locking"
}