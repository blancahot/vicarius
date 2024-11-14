resource "aws_iam_role" "service_account_role" {
  name = "${var.prefix}-${var.name}"
  assume_role_policy = templatefile("${var.policy_folder}/sa_assume_role_policy.json",
    {
      ACCOUNT_ID          = data.aws_caller_identity.current.account_id,
      EKS_OIDC_PROVIDER   = var.eks_oidc_provider,
      SERVICEACCOUNT_PATH = var.service_account_path
  })
}

resource "aws_iam_role_policy" "service_account_policy" {
  for_each = { for i, policy in tolist(var.inline_policies) : i => policy }
  name     = "${var.prefix}-${var.name}-policy-${each.key}"
  role     = aws_iam_role.service_account_role.name
  policy   = each.value
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each   = { for i, policy in tolist(var.managed_policies) : i => policy }
  role       = aws_iam_role.service_account_role.name
  policy_arn = each.value
}