provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_dns_managed_zone" "gcp_dns_zone" {
  name        = var.gcp_zone_name
  dns_name    = var.gcp_dns_name
  description = var.gcp_zone_description

  lifecycle {
    prevent_destroy = true
  }
}

output "gcp_dns_zone_name_servers" {
  value = google_dns_managed_zone.gcp_dns_zone.name_servers
}

resource "google_dns_managed_zone" "dev_zone" {
  name        = var.dev_zone_name
  dns_name    = var.dev_dns_name
  description = var.dev_zone_description

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_dns_managed_zone" "prd_zone" {
  name        = var.prd_zone_name
  dns_name    = var.prd_dns_name
  description = var.prd_zone_description

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_dns_record_set" "dev_zone_ns_records_set" {
  name         = google_dns_managed_zone.dev_zone.dns_name
  managed_zone = google_dns_managed_zone.gcp_dns_zone.name
  type         = "NS"
  ttl          = var.dns_ttl
  rrdatas      = google_dns_managed_zone.dev_zone.name_servers

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_dns_record_set" "prd_zone_ns_records_set" {
  name         = google_dns_managed_zone.prd_zone.dns_name
  managed_zone = google_dns_managed_zone.gcp_dns_zone.name
  type         = "NS"
  ttl          = var.dns_ttl
  rrdatas      = google_dns_managed_zone.prd_zone.name_servers

  lifecycle {
    prevent_destroy = true
  }
}