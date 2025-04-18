terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-sa-key.json")
  project     = var.project_id
  region      = var.region
}

data "google_client_config" "default" {}
provider "kubernetes" {
  host                   = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
