provider "google" {
  credentials = file(var.my_credentials)
  project     = var.project
  region      = var.region
}