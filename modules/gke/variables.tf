variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where the VM will be created"
  type        = string
}

variable "region" {
  description = "Region for the VM"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "gcp-dev-7125"
}

variable "env_name" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
  default     = "dev"
}
