###########
# VPC
###########
module "vpc" {
  source = "../../modules/networking/vpc"

  prefix = local.prefix
  cidr   = var.vpc_cidr

  single_nat_gateway           = var.single_nat_gateway
  one_nat_gateway_per_az       = var.one_nat_gateway_per_az
  create_database_subnet_group = var.vpc_create_database_subnet_group

  # Flow Logs
  enable_flow_log                                 = var.enable_vpc_flow_log
  create_flow_log_cloudwatch_log_group            = var.create_vpc_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role             = var.create_vpc_flow_log_cloudwatch_iam_role
  flow_log_max_aggregation_interval               = var.vpc_flow_log_max_aggregation_interval
  flow_log_cloudwatch_log_group_retention_in_days = var.vpc_flow_log_cloudwatch_log_group_retention_in_days

  tags = local.tags
}

###########
# EKS
###########
module "eks" {
  source = "../../modules/compute/eks"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


  prefix                          = local.prefix
  cluster_version                 = var.eks_cluster_version
  cluster_endpoint_private_access = var.eks_cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.eks_cluster_endpoint_public_access

  create_cloudwatch_log_group            = var.eks_create_cloudwatch_log_group
  cluster_enabled_log_types              = var.eks_cluster_enabled_log_types
  cloudwatch_log_group_retention_in_days = var.eks_cloudwatch_log_group_retention_in_days


  access_entries = var.eks_access_entries

  node_group_disk_size      = var.eks_node_group_disk_size
  node_group_min_size       = var.eks_node_group_min_size
  node_group_desired_size   = var.eks_node_group_desired_size
  node_group_max_size       = var.eks_node_group_max_size
  node_group_capacity_type  = var.eks_node_group_capacity_type
  node_group_instance_types = var.eks_node_group_instance_types

  tags = local.tags
}

###########
# IRSA - IAM Role for Service Accounts
####################################
module "irsa" {
  source = "../../modules/management/irsa"

  prefix            = local.prefix
  policy_folder     = var.irsa_policy_path
  eks_oidc_provider = module.eks.oidc_provider

  for_each             = local.service_accounts
  name                 = each.key
  service_account_path = lookup(each.value, "service_account_path", null)
  inline_policies      = lookup(each.value, "inline_policies", [])
  managed_policies     = lookup(each.value, "managed_policies", [])
}