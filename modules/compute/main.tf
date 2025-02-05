# Public IP address
resource "google_compute_address" "public_ip" {
  name        = "${var.vm_name}-ip"
  region      = var.region
  description = "Public IP for ${var.vm_name}"
}

resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = "${var.region}-${var.zone_suffix}"

  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.private_subnet_id

    # This access_config block gives the instance a public IP
    # Even though it's in a private subnet
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }

  tags = concat(var.network_tags, ["private-subnet-vm"])

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.env_name}-allow-ssh"
  network = var.vpc_id

  description = "Allow SSH access to public VMs"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # You might want to restrict this to specific IP ranges
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["public-vm"]
}
