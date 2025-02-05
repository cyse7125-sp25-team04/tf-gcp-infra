terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "> 5.0"
    }
  }
}

provider "google" {
  credentials = file("/Users/shalomdaniel/.config/gcloud/application_default_credentials.json")
  project     = var.project_id
  region      = var.region
}
