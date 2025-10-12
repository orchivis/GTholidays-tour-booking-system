output "lambda_code_bucket" {
  value = aws_s3_bucket.lambda_code.bucket
}

output "website_bucket_endpoint" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
}
