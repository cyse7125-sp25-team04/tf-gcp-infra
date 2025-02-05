variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
}

variable "pod_ip_range" {
  description = "CIDR for pod IP range"
  type        = string
}

variable "service_ip_range" {
  description = "CIDR for service IP range"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
