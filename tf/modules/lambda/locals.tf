locals {
  env = terraform.workspace
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  timeout       = 15
  memory_size   = 256
  project       = "gtholidays"


lambdas = {
  tourbooking = {
  function_name = "lam-${local.env}-gtholidays-tour-booking"
  s3_bucket     = "s3-${local.env}-gtholidays-tour-booking"
  s3_key        = "lambda/tourbooking.zip"
}

  toursearch = {
  function_name = "lam-${local.env}-gtholidays-tour-search"
  s3_bucket     = "s3-${local.env}-gtholidays-tour-search"
  s3_key        = "lambda/toursearch.zip"
}
}
}