locals {
  prefix = "${basename(path.cwd)}-barkuni"
  tags = {
    ManagedBy   = "terraform"
    Project     = "barkuni"
    Environment = var.environment
    Region      = var.region
  }

  service_accounts = {
    aws-load-balancer-controller = {
      service_account_path = "system:serviceaccount:kube-system:aws-load-balancer-controller-sa"
      inline_policies = [
        file("${var.irsa_policy_path}/aws_load_balancer_controller_policy.json")
      ]
    }
    public-eks-external-dns = {
      service_account_path = "system:serviceaccount:kube-system:public-eks-external-dns-sa"
      inline_policies = [
        templatefile("${var.irsa_policy_path}/aws_eks_external_dns_policy.json",
          {
            HOSTED_ZONE_ID = data.aws_route53_zone.public.zone_id
      })]
    }
    cluster-autoscaler = {
      service_account_path = "system:serviceaccount:kube-system:cluster-autoscaler-sa"
      inline_policies = [
        file("${var.irsa_policy_path}/cluster_autoscaler_policy.json")
      ]
    }
  }
}
