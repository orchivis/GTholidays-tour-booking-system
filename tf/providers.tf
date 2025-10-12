terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "aws-dev-orchivis-usecase1-tfstate"   # bootstrap bucket
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "aws-dev-orchivis-usecase1-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
