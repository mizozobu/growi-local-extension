resource "google_storage_bucket" "growi" {
  name = var.bucket_name
  location = "US"
  force_destroy = true
}
