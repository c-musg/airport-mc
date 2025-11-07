variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region for observability tooling."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region telemetry pipelines."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply."
  type        = map(string)
  default     = {}
}

variable "log_groups" {
  description = "CloudWatch log group definitions."
  type        = list(map(any))
  default     = []
}

variable "alarms" {
  description = "CloudWatch alarm definitions."
  type        = list(map(any))
  default     = []
}

variable "dashboards" {
  description = "CloudWatch dashboard definitions."
  type        = list(map(any))
  default     = []
}
