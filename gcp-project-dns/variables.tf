variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "csye7125-dns-449902"
}
variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-east-1"
}

variable "gcp_zone_name" {
  description = "Name of the main GCP managed DNS zone"
  type        = string
  default     = "gcp-managed-zone"
}

variable "gcp_dns_name" {
  description = "DNS name of the main GCP managed zone"
  type        = string
  default     = "gcp.csye7125.xyz."
}

variable "gcp_zone_description" {
  description = "Description of the main GCP managed zone"
  type        = string
  default     = "Subdomain of csye.xyz for managing Google services"
}

variable "dev_zone_name" {
  description = "Name of the development managed DNS zone"
  type        = string
  default     = "dev-managed-zone"
}

variable "dev_dns_name" {
  description = "DNS name of the development managed zone"
  type        = string
  default     = "dev.gcp.csye7125.xyz."
}

variable "dev_zone_description" {
  description = "Description of the development managed zone"
  type        = string
  default     = "Subdomain of gcp.csye.xyz for accessing the dev services"
}

variable "prd_zone_name" {
  description = "Name of the production managed DNS zone"
  type        = string
  default     = "prd-managed-zone"
}

variable "prd_dns_name" {
  description = "DNS name of the production managed zone"
  type        = string
  default     = "prd.gcp.csye7125.xyz."
}

variable "prd_zone_description" {
  description = "Description of the production managed zone"
  type        = string
  default     = "Subdomain of gcp.csye.xyz for accessing the prd services"
}

variable "dns_ttl" {
  description = "TTL for the DNS record sets"
  type        = number
  default     = 60
}