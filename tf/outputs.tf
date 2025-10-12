# Lambda outputs
output "lambda_function_name" {
  value = module.tour_search_lambda.lambda_function_name
}

output "lambda_function_arn" {
  value = module.tour_search_lambda.lambda_arn
}

# S3 outputs
output "lambda_code_bucket" {
  value = module.s3_buckets.lambda_code_bucket
}

output "website_bucket_endpoint" {
  value = module.s3_buckets.website_bucket_endpoint
}
