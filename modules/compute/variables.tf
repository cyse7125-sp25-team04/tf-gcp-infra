variable "vm_name" {
  description = "Name of the VM instance"
  type        = string

  validation {
    condition     = can(regex("^[a-z][-a-z0-9]*[a-z0-9]$", var.vm_name))
    error_message = "VM name must start with a letter, only contain lowercase letters, numbers, and hyphens, and end with a letter or number."
  }
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-medium"
}

variable "region" {
  description = "Region for the VM"
  type        = string
}

variable "zone_suffix" {
  description = "Zone suffix (a, b, or c)"
  type        = string
  default     = "b"

  validation {
    condition     = can(regex("^[a-c]$", var.zone_suffix))
    error_message = "Zone suffix must be either 'a', 'b', or 'c'."
  }
}

variable "disk_image" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 50

  validation {
    condition     = var.disk_size_gb >= 10 && var.disk_size_gb <= 65536
    error_message = "Disk size must be between 10GB and 65536GB."
  }
}

variable "disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"

  validation {
    condition     = contains(["pd-standard", "pd-balanced", "pd-ssd"], var.disk_type)
    error_message = "Disk type must be one of: pd-standard, pd-balanced, pd-ssd."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where the VM will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where the VM will be created"
  type        = string
}

variable "network_tags" {
  description = "Network tags to apply to the instance"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.network_tags) <= 64
    error_message = "Maximum number of network tags is 64."
  }
}

variable "service_account_email" {
  description = "Service account email. If empty, the default compute service account will be used"
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["cloud-platform"]

  validation {
    condition     = length(var.service_account_scopes) > 0
    error_message = "At least one service account scope must be provided."
  }
}

variable "enable_public_ip" {
  description = "Whether to enable public IP for the VM"
  type        = bool
  default     = true
}

variable "metadata" {
  description = "Additional metadata key/value pairs to add to the instance"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(var.labels) <= 64
    error_message = "Maximum number of labels is 64."
  }
}

variable "env_name" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
  default     = "dev"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
