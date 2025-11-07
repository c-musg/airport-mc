variable "environment" {
  description = "Short environment identifier (e.g. dev, staging, prod)."
  type        = string
}

variable "region" {
  description = "AWS region where resources should be created."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile toggle that gates optional/expensive resources."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region or higher resilience features in this module."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of AWS resource tags to apply."
  type        = map(string)
  default     = {}
}

variable "log_groups" {
  description = "CloudWatch log group definitions."
  type = list(object({
    name              = string
    retention_in_days = optional(number)
    kms_key_id        = optional(string)
  }))
  default = []
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
