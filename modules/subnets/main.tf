resource "google_compute_subnetwork" "private" {
  name                     = "${var.env_name}-private-subnet"
  ip_cidr_range            = var.private_subnet_cidr
  network                  = var.vpc_id
  region                   = var.region
  project                  = var.project_id
  private_ip_google_access = false

  secondary_ip_range {
    range_name    = "pod-ip-range"
    ip_cidr_range = var.pod_ip_range
  }

  secondary_ip_range {
    range_name    = "service-ip-range"
    ip_cidr_range = var.service_ip_range
  }
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.env_name}-public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  network       = var.vpc_id
  region        = var.region
  project       = var.project_id
}
