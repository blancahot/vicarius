# General
environment = "dev"
region      = "us-east-1"

# Route53
public_hosted_zone_name = "vicarius.xyz"

# VPC
vpc_cidr                                 = "10.0.0.0/16"
single_nat_gateway                       = true
one_nat_gateway_per_az                   = false
vpc_create_database_subnet_group         = false
enable_vpc_flow_log                      = false
create_vpc_flow_log_cloudwatch_log_group = false
create_vpc_flow_log_cloudwatch_iam_role  = false

# EKS
eks_cluster_version                 = "1.30"
eks_cluster_endpoint_private_access = false
eks_cluster_endpoint_public_access  = true
eks_create_cloudwatch_log_group     = false
eks_node_group_disk_size            = 20
eks_node_group_min_size             = 2
eks_node_group_desired_size         = 2
eks_node_group_max_size             = 4
eks_node_group_capacity_type        = "SPOT"
eks_node_group_instance_types       = ["t2.medium"]

# IRSA
irsa_policy_path = "../../irsa_policies"
