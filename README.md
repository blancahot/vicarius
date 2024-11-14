# Vicarius

## Barkuni Corp Home Assignment

This repository contains the code and infrastructure for the Barkuni Candidate Assessment System. It is designed to manage candidates and their skill assessments using a Flask API, along with infrastructure management using Terraform and deployment via Helm.

## Overview

- **Candidate Assessment API**: A Flask-based API for managing candidates and their assessments. It includes endpoints for creating candidates, listing them, and adding assessments. The application can be run locally or in a Docker container.

- **Terraform Infrastructure**: Contains configurations for managing AWS infrastructure, organized into reusable modules. Key components include VPC setup, EKS cluster management, and IAM Roles for Service Accounts (IRSA).

- **Helm Charts**: Used for packaging and deploying the Candidate Assessment API and other components to a Kubernetes cluster, facilitating easy management of application deployments.

- **Continuous Integration(CI)**: Implemented using GitHub Actions to automate testing and build processes for the Candidate Assessment API, including building Docker images and pushing them to Amazon ECR.

- **EC2 Instance Creation Script**: A Python script that automates the creation of EC2 instances in AWS, requiring configured AWS credentials and a key pair for SSH access.

## Getting Started

To get started, follow the instructions in the respective README files located in each directory. This will guide you through setting up the application, infrastructure, and deployment processes.
