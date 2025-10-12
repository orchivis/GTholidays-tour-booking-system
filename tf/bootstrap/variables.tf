variable "state_bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = "aws-dev-orchivis-usecase1-tfstate"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
  default     = "aws-dev-orchivis-usecase1-locks"
}

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "ap-south-1"
}