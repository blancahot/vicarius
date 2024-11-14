# General
variable "prefix" {
  type        = string
  description = "Prefix for the EKS cluster"
}

# VPC
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private Subnets"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Enable private access to the cluster endpoint"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Enable public access to the cluster endpoint"
}

# EKS
variable "cluster_version" {
  description = "The Kubernetes version that is supported with Amazon EKS."
  type        = string
}
variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs."
  type        = bool
}
variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable."
  type        = list(string)
  default     = []
}

variable "access_entries" {
  type        = any
  default     = {}
  description = "AWS Access Entries"
}

variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "The number of days to retain the CloudWatch log group"
  default     = 1
}

variable "node_group_disk_size" {
  type        = number
  description = "The size of the EKS node group disk"
}

variable "node_group_min_size" {
  type        = number
  description = "The minimum number of nodes in the node group"
}

variable "node_group_max_size" {
  type        = number
  description = "The maximum number of nodes in the node group"
}

variable "node_group_desired_size" {
  type        = number
  description = "The desired number of nodes in the node group"
}

variable "node_group_instance_types" {
  type        = list(string)
  description = "The instance type of the node group"
}

variable "node_group_capacity_type" {
  type        = string
  description = "Node group ec2 type: ON_DEMAND/SPOT"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the EKS cluster"
}
