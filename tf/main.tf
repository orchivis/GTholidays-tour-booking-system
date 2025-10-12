# Call S3 module
module "s3_buckets" {
  source = "./modules/S3"

  lambda_s3_bucket  = var.lambda_s3_bucket
  website_s3_bucket = var.website_s3_bucket
}

# Call Lambda module
module "tour_search_lambda" {
  source = "./modules/lambda"

  function_name   = var.lambda_function_name
  s3_bucket       = module.s3_buckets.lambda_code_bucket  # depend on S3 output
  s3_key          = var.lambda_s3_key
  runtime         = var.lambda_runtime
  handler         = var.lambda_handler
  timeout         = var.lambda_timeout
  memory_size     = var.lambda_memory_size
}
