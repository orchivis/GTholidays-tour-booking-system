locals {
  env       = terraform.workspace
  project   = "gtholidays"
  api_name  = "api-${local.env}-${local.project}"
  stage_name = "dev"

  resources = {
    tourbooking = {
      path_part    = "booktour"
      http_method  = "POST"
      lambda_key   = "tourbooking"
    }
    toursearch = {
      path_part    = "searchtour"
      http_method  = "GET"
      lambda_key   = "toursearch"
    }
  }

  tags = {
    Environment = terraform.workspace
    Project     = local.project
    ManagedBy   = "Terraform"
  }
}
