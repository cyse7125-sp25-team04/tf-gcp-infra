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

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-east1"
}
