

module "vpc" {
  source     = "../modules/vpc"
  vpc_name   = "${var.env_name}-vpc"
  project_id = var.project_id
}

module "subnets" {
  source              = "../modules/subnets"
  env_name            = var.env_name
  vpc_id              = module.vpc.vpc_id
  region              = var.region
  project_id          = var.project_id
  private_subnet_cidr = "10.0.0.0/20"  # Private subnet for GKE nodes
  public_subnet_cidr  = "10.1.0.0/20"  # Public subnet for bastion/load balancers
  pod_ip_range        = "10.16.0.0/12" # Pod IP range
  service_ip_range    = "10.32.0.0/16" # Service IP range
}

module "router" {
  source     = "../modules/router"
  env_name   = var.env_name
  vpc_id     = module.vpc.vpc_id
  region     = var.region
  project_id = var.project_id
}

module "compute" {
  source            = "../modules/compute"
  vm_name           = "${var.env_name}-vm"
  region            = var.region
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.subnets.private_subnet_id # Using private subnet
  public_subnet_id  = module.subnets.public_subnet_id
  machine_type      = "e2-medium"
  network_tags      = ["private-vm", "${var.env_name}-private"]
  project_id        = var.project_id

  depends_on = [module.vpc, module.subnets]
}

module "gke" {
  source            = "../modules/gke"
  env_name          = var.env_name
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.subnets.private_subnet_id # Using private subnet
  region            = var.region
  project_id        = var.project_id

  depends_on = [module.vpc, module.subnets]
}
