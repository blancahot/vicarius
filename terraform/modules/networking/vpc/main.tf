############
# Networking
############
data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0" # https://github.com/terraform-aws-modules/terraform-aws-vpc/releases/tag/v5.15.0
  name    = "${var.prefix}-vpc"

  # Set the address space for VPC
  cidr = var.cidr

  # Set Availability Zones and Subnets
  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(var.cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.cidr, 8, k + 4)]

  # Subnet names
  private_subnet_names = [for k, v in local.azs : "${var.prefix}-private-${local.azs[k]}"]
  public_subnet_names  = [for k, v in local.azs : "${var.prefix}-public-${local.azs[k]}"]

  # Subnet tags
  private_subnet_tags = merge(var.tags, {
    "Tier"                            = "private"
    "kubernetes.io/role/internal-elb" = "1"
  })
  public_subnet_tags = merge(var.tags, {
    "Tier"                   = "public"
    "kubernetes.io/role/elb" = "1"
  })

  # Database Subnets
  create_database_subnet_group  = var.create_database_subnet_group
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  # NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = var.single_nat_gateway # The nat gateway will be placed in the first public subnet.
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  #  Internet Gateway
  create_igw = true

  # The VPC must have DNS hostname and DNS resolution support, or EKS Fargate/EC2 nodes can't register with the EKS Cluster.
  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  enable_dns_hostnames = true
  enable_dns_support   = true


  # VPC Flow Logs
  # Cloudwatch log group and IAM role will be created
  enable_flow_log                      = var.enable_flow_log
  create_flow_log_cloudwatch_log_group = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role  = var.create_flow_log_cloudwatch_iam_role

  flow_log_max_aggregation_interval               = var.enable_flow_log ? var.flow_log_max_aggregation_interval : 0
  flow_log_cloudwatch_log_group_name_prefix       = "/aws/${var.prefix}-vpc/"
  flow_log_cloudwatch_log_group_retention_in_days = var.enable_flow_log ? var.flow_log_cloudwatch_log_group_retention_in_days : 0

  vpc_flow_log_tags = var.tags

  # Tags for all resources
  tags = var.tags
}