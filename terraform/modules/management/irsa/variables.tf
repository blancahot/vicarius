# General
variable "prefix" {
  description = "The prefix"
  type        = string
}

variable "policy_folder" {
  description = "The folder where the policies are stored"
  default     = "policies"
}

variable "name" {
  description = "The name of the service account"
  type        = string
}

variable "service_account_path" {
  description = "The path of the service account"
  type        = string
  default     = null
}

variable "inline_policies" {
  description = "The path of the policy"
  type        = list(any)
  default     = []
}
variable "managed_policies" {
  description = "The path of the policy"
  type        = list(string)
  default     = []
}
variable "eks_oidc_provider" {
  description = "EKS OIDC provider"
  type        = string
}