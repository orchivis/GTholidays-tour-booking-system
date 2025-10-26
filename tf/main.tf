# Call S3 module
module "s3_buckets" {
  source = "./modules/S3"
}

# Call Lambda module
module "tour_search_lambda" {
  source = "./modules/lambda"
}
