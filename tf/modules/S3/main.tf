# Lambda code bucket
resource "aws_s3_bucket" "buckets" {
  for_each = local.buckets
  bucket   = each.value.name

  tags = {
  Environment = terraform.workspace
  Project     = "gtholidays"
  ManagedBy   = "Terraform"
  }
}

# Enable versioning where needed
resource "aws_s3_bucket_versioning" "versioning" {
  for_each = { for k, v in local.buckets : k => v if v.versioning }
  bucket   = aws_s3_bucket.buckets[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

# Static website bucket
resource "aws_s3_bucket" "static_site" {
  bucket = local.website_s3_bucket

  tags = {
  Environment = terraform.workspace
  Project     = "gtholidays"
  ManagedBy   = "Terraform"
  }
}

# Configure website hosting where needed
resource "aws_s3_bucket_website_configuration" "website" {
  for_each = { for k, v in local.buckets : k => v if v.website }
  bucket   = aws_s3_bucket.buckets[each.key].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
