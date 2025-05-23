
resource "google_container_cluster" "my_cluster" {
  project                  = var.project_id
  name                     = "${var.env_name}-gke-cluster"
  location                 = var.region
  network                  = var.vpc_id
  subnetwork               = var.private_subnet_id
  remove_default_node_pool = true
  initial_node_count       = 1
  min_master_version       = "1.30.9"

  node_config {
    disk_type = "pd-standard"
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
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

  timeouts {
    delete = "40m" # Adjust as needed for your environment
  }

  deletion_protection = false
}

resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "gke_node_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_project_iam_member" "gke_node_service" {
  project = var.project_id
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}


resource "google_container_node_pool" "node-pool-1" {
  name           = "node-pool-1"
  location       = var.region
  cluster        = google_container_cluster.my_cluster.name
  node_count     = 1
  node_locations = ["us-east1-b"]

  node_config {
    service_account = google_service_account.gke_node_sa.email
    image_type   = "COS_CONTAINERD"
    machine_type = "n1-standard-4"
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "node-pool-2" {
  name           = "node-pool-2"
  location       = var.region
  cluster        = google_container_cluster.my_cluster.name
  node_count     = 1
  node_locations = ["us-east1-c"]

  node_config {
    service_account = google_service_account.gke_node_sa.email
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium"
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "node-pool-3" {
  name           = "node-pool-3"
  location       = var.region
  cluster        = google_container_cluster.my_cluster.name
  node_count     = 1
  node_locations = ["us-east1-d"]

  node_config {
    service_account = google_service_account.gke_node_sa.email
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-medium"
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


resource "google_service_account" "bucket_updater" {
  account_id   = "bucket-access"
  display_name = "Bucket Access"

}

resource "google_project_iam_member" "bucket_updater_role" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.bucket_updater.email}"
}

resource "google_project_iam_member" "service_usage_permission" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${google_service_account.bucket_updater.email}"
}

/*
resource "kubernetes_namespace" "webapp" {
  metadata {
    name = "webapp"
  }  
  depends_on = [google_container_cluster.my_cluster]
}
*/

/*
resource "kubernetes_service_account" "name" {
  metadata {
    name = "pod-service-account"
    namespace = kubernetes_namespace.webapp.metadata.0.name
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.bucket_updater.email
    }
  }
  depends_on = [
    kubernetes_namespace.webapp,
    google_container_cluster.my_cluster
  ]
}
*/

resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.bucket_updater.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[webapp/pod-service-account]"
  ]
}

/*
resource "null_resource" "install_istio" {
  depends_on = [google_container_cluster.my_cluster]

  provisioner "local-exec" {
    command = "istioctl install -f custom-istio.yaml --skip-confirmation"
  }
}
*/
