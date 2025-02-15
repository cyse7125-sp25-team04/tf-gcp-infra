resource "google_compute_router" "router" {
  name    = "${var.env_name}-router"
  network = var.vpc_id
  region  = var.region
  project = var.project_id
}

# Create NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "${var.env_name}-nat"
  project                            = var.project_id
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
