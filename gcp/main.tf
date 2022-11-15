terraform {
  backend "local" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
  required_version = ">= 1.3.4"
}

provider "google" {
  project                 = var.project
  region                  = var.region
  zone                    = var.zone
  access_token            = var.access_token
  storage_custom_endpoint = "http://localhost:4443/storage/v1/"
}

module "gcs" {
  source      = "./modules/gcs"
  bucket_name = var.bucket_name
}
