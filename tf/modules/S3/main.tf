# Lambda code bucket
resource "aws_s3_bucket" "lambda_code" {
  bucket = var.lambda_s3_bucket
}

resource "aws_s3_bucket_versioning" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Static website bucket
resource "aws_s3_bucket" "static_site" {
  bucket = var.website_s3_bucket
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
