locals {
  env = terraform.workspace
  dynamodb_table_name = "ddb-${local.env}-tflock"
  state_bucket_name   = "s3-${local.env}-tfstate"
  aws_region          = "ap-south-1"
}
