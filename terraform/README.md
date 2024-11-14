# Terraform Infrastructure

This repository contains Terraform configurations for managing infrastructure on AWS. The configurations are organized into modules and projects, allowing for reusable and maintainable infrastructure as code.

## Directory Structure

- `projects/`: Contains specific project configurations.
  - `dev/`: Development environment configurations.
    - `backend.tf`: Configuration for the Terraform backend.
    - `main.tf`: Main configuration file for the project.
    - `locals.tf`: Local variables used in the project.
    - `vars/`: Variable definitions for the project.
      - `dev.tfvars`: Variable values for the development environment.
  - `versions.tf`: Specifies the required Terraform version and providers.

- `modules/`: Contains reusable Terraform modules.
  - `management/`: Management-related modules.
    - `irsa/`: Module for managing IAM Roles for Service Accounts (IRSA).
  - `compute/`: Compute-related modules.
    - `eks/`: Module for managing Amazon EKS clusters.
  - `networking/`: Networking-related modules.
    - `vpc/`: Module for managing VPCs.

- `irsa_policies/`: Contains JSON policy documents for IRSA.

## Getting Started

To get started with this Terraform configuration, follow these steps:

1. **Install Terraform**: Ensure you have Terraform installed on your machine. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).

2. **Configure AWS Credentials**: Set up your AWS credentials using the AWS CLI or by exporting environment variables.

3. **Initialize Terraform**: Navigate to the project directory and run the following command to initialize Terraform:

   ```bash
   terraform init
   ```

4. **Plan the Infrastructure**: Run the following command to see the execution plan:

   ```bash
   terraform plan -var-file="vars/dev.tfvars"
   ```

5. **Apply the Configuration**: To create the infrastructure, run:

   ```bash
   terraform apply -var-file="vars/dev.tfvars"
   ```

6. **Destroy the Infrastructure**: To remove the infrastructure, run:

   ```bash
   terraform destroy -var-file="vars/dev.tfvars"
   ```

