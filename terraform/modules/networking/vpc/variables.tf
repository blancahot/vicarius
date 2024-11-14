# VPC
variable "prefix" {
  type        = string
  description = "Prefix for the VPC"
}
variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}
variable "single_nat_gateway" {
  type        = bool
  description = "Enable a single NAT gateway for the VPC"
}

variable "one_nat_gateway_per_az" {
  type        = bool
  description = "Enable one NAT gateway per availability zone for the VPC"
}

variable "create_database_subnet_group" {
  type        = bool
  description = "Enable the database subnet group for the VPC"
}


# Flow Logs
variable "enable_flow_log" {
  type        = bool
  description = "Enable the flow logs for the VPC"
}
variable "create_flow_log_cloudwatch_log_group" {
  type        = bool
  description = "Enable the CloudWatch log group for the flow logs"
}
variable "create_flow_log_cloudwatch_iam_role" {
  type        = bool
  description = "Enable the IAM role for the flow logs"
}
variable "flow_log_max_aggregation_interval" {
  type        = number
  description = "The maximum aggregation interval for the flow logs"
}
variable "flow_log_cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "The retention period for the CloudWatch log group"
}

variable "tags" {
  type        = map(string)
  description = "The tags for the VPC"
}
