resource "google_compute_router" "router" {
  name    = "${var.env_name}-router"
  network = var.vpc_id
  region  = var.region
  project = var.project_id
}
