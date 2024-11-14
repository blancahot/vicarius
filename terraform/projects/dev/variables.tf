# General
variable "environment" {
  type        = string
  description = "The environment"
}

variable "region" {
  type        = string
  description = "The region"
}

# VPC
variable "vpc_cidr" {
  type        = string
  description = "The CIDR for the VPC"
}
variable "single_nat_gateway" {
  type        = bool
  description = "Enable a single NAT gateway for the VPC"
}
variable "one_nat_gateway_per_az" {
  type        = bool
  description = "Enable one NAT gateway per availability zone for the VPC"
}
variable "vpc_create_database_subnet_group" {
  type        = bool
  description = "Enable the creation of a database subnet group"
}

# Flow Logs
variable "enable_vpc_flow_log" {
  type        = bool
  description = "Enable the flow logs for the VPC"
}
variable "create_vpc_flow_log_cloudwatch_log_group" {
  type        = bool
  description = "Enable the creation of a CloudWatch log group for the flow logs"
}
variable "create_vpc_flow_log_cloudwatch_iam_role" {
  type        = bool
  description = "Enable the creation of a CloudWatch IAM role for the flow logs"
}
variable "vpc_flow_log_max_aggregation_interval" {
  type        = number
  description = "The maximum aggregation interval for the flow logs"
  default     = 0
}
variable "vpc_flow_log_cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "The retention period for the CloudWatch log group for the flow logs"
  default     = 0
}

# EKS
variable "eks_cluster_version" {
  type        = string
  description = "The version of the EKS cluster"
}
variable "eks_cluster_endpoint_private_access" {
  type        = bool
  description = "Enable private access to the EKS cluster"
}
variable "eks_cluster_endpoint_public_access" {
  type        = bool
  description = "Enable public access to the EKS cluster"
}
variable "eks_create_cloudwatch_log_group" {
  type        = bool
  description = "Enable the creation of a CloudWatch log group for the EKS cluster"
}
variable "eks_cluster_enabled_log_types" {
  type        = list(string)
  description = "The types of logs to enable for the EKS cluster"
  default     = []
}
variable "eks_cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "The retention period for the CloudWatch log group for the EKS cluster"
  default     = 0
}
variable "eks_access_entries" {
  type        = any
  default     = {}
  description = "The access entries for the EKS cluster"
}

# EKS Managed Node Group
variable "eks_node_group_disk_size" {
  type        = number
  description = "The size of the EKS node group disk"
}
variable "eks_node_group_min_size" {
  type        = number
  description = "The minimum number of nodes in the EKS node group"
}
variable "eks_node_group_desired_size" {
  type        = number
  description = "The desired number of nodes in the EKS node group"
}
variable "eks_node_group_max_size" {
  type        = number
  description = "The maximum number of nodes in the EKS node group"
}
variable "eks_node_group_capacity_type" {
  type        = string
  description = "The capacity type for the EKS node group"
}
variable "eks_node_group_instance_types" {
  type        = list(string)
  description = "The instance types for the EKS node group"
}

# IRSA
variable "irsa_policy_path" {
  type        = string
  description = "The path to the IRSA policies"
}

# Route53
variable "public_hosted_zone_name" {
  type        = string
  description = "The name of the public Route53 hosted zone"
}
