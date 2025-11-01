# Call S3 module
module "s3_buckets" {
  source = "./modules/S3"
}

# Call Lambda module
module "tour_search_lambda" {
  source = "./modules/lambda"
}

# Call api
module "api_gateway" {
  source = "./api_gateway"

  region      = var.region
  stage_name  = "dev"

  lambda_functions = {
    tourbooking = {
      function_name = aws_lambda_function.this["tourbooking"].function_name
      invoke_arn    = aws_lambda_function.this["tourbooking"].invoke_arn
    }
    toursearch = {
      function_name = aws_lambda_function.this["toursearch"].function_name
      invoke_arn    = aws_lambda_function.this["toursearch"].invoke_arn
    }
  }
}
