terraform {
  backend "local" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.39"
    }
  }
  required_version = ">= 1.3.4"
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  s3_use_path_style = true
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id  = true
  endpoints {
    iam      = "http://localhost:4566"
    kinesis  = "http://localhost:4566"
    lambda   = "http://localhost:4566"
    s3       = "http://localhost:4566"
  }
}

module "s3" {
  source = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}
