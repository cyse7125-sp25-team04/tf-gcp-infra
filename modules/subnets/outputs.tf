output "private_subnet_id" {
  value = google_compute_subnetwork.private.id
}

output "public_subnet_id" {
  value = google_compute_subnetwork.public.id
}

output "private_subnet_cidr" {
  value = google_compute_subnetwork.private.ip_cidr_range
}

output "pod_ip_range" {
  value = google_compute_subnetwork.private.secondary_ip_range[0].ip_cidr_range
}

output "service_ip_range" {
  value = google_compute_subnetwork.private.secondary_ip_range[1].ip_cidr_range
}
