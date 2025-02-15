# Terraform GCP Infrastructure

This Terraform project uses modules to create and manage infrastructure on Google Cloud Platform (GCP). The project is structured to allow reusable and modular infrastructure components.

## Modules

The following Terraform modules are used to provision infrastructure:


## Prerequisites

Before using this Terraform configuration, ensure you have:

1. A Google Cloud project.
2. Installed Terraform (v1.0+ recommended).
3. Configured authentication using a service account:
   ```sh
   gcloud auth application-default login
   ```

## Getting Started

### 1. Clone the Repository
```sh
git clone <repository-url>
cd <repository-folder>
```

### 2. Initialize Terraform
```sh
terraform init
```

### 3. Plan the Infrastructure
```sh
terraform plan
```

### 4. Apply the Configuration
```sh
terraform apply
```

### 5. Destroy the Infrastructure (if needed)
```sh
terraform destroy
```

## Notes
- Modify `variables.tf` to customize resources before applying.
- Ensure billing is enabled for your GCP project.
- Use `terraform fmt` to format code and `terraform validate` to check for errors before applying changes.

## References
- [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Cloud Terraform Modules](https://github.com/terraform-google-modules)


