output "cluster_endpoint" {
  value = google_container_cluster.my_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate
}
