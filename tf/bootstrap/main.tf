provider "aws" {
  region = local.aws_region
}

# S3 bucket for state
resource "aws_s3_bucket" "tf_state" {
  bucket = local.state_bucket_name

  tags = {
    Environment = terraform.workspace
    Project     = "gtholidays"
    ManagedBy   = "Terraform"
  }
}

# Enable versioning (important for state recovery)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = terraform.workspace
    Project     = "gtholidays"
    ManagedBy   = "Terraform"
  }
}