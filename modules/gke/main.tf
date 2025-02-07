resource "google_container_cluster" "my_cluster" {
  project                  = var.project_id
  name                     = "${var.env_name}-gke-cluster"
  location                 = var.region
  network                  = var.vpc_id
  subnetwork               = var.private_subnet_id
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    disk_type = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-ip-range"
    services_secondary_range_name = "k8s-service-ip-range"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  deletion_protection = false
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  project    = var.project_id
  name       = "${var.env_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.my_cluster.name
  node_count = 1

  #autoscaling {
  #  total_min_node_count = var.min_node_count
  #  total_max_node_count = var.max_node_count
  #}

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 10
    image_type   = "COS_CONTAINERD"
    disk_type    = "pd-standard"
    labels = {
      team = "gke"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
