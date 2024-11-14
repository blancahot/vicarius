module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.29.0" # https://github.com/terraform-aws-modules/terraform-aws-eks/releases/tag/v20.29.0

  # General
  create                                 = true
  cluster_name                           = "${var.prefix}-eks"
  cluster_version                        = var.cluster_version
  create_kms_key                         = true
  kms_key_enable_default_policy          = true
  authentication_mode                    = "API"
  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cluster_enabled_log_types              = var.cluster_enabled_log_types
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  cluster_encryption_config = {
    resources = ["secrets"]
  }

  # AWS Access Entries
  enable_cluster_creator_admin_permissions = true

  access_entries = var.access_entries


  # Network Settings
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access


  # Nodes Security rules
  # Ingress
  node_security_group_additional_rules = {
    http = {
      description = "HTTP Node to node, clusterIP"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "ingress"
      self        = true
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    default = {
      name           = "default"
      subnet_ids     = [var.subnet_ids[0]]
      disk_size      = var.node_group_disk_size
      min_size       = var.node_group_min_size
      max_size       = var.node_group_max_size
      desired_size   = var.node_group_desired_size
      instance_types = var.node_group_instance_types
      capacity_type  = var.node_group_capacity_type

      tags = merge(var.tags, {
        "k8s.io/cluster-autoscaler/enabled"           = "true"
        "k8s.io/cluster-autoscaler/${var.prefix}-eks" = "true"
      })
    }
  }

  # EKS Addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  tags = var.tags
}