variable "state_bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = local.state_bucket_name
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
  default     = local.dynamodb_table_name
}

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "ap-south-1"
}