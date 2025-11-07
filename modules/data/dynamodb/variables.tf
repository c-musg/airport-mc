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

variable "tables" {
  description = "DynamoDB table definitions."
  type = list(object({
    name                 = string
    billing_mode         = optional(string)
    hash_key             = string
    range_key            = optional(string)
    attributes           = list(map(string))
    stream_enabled       = optional(bool)
    point_in_time_recovery = optional(bool)
    replica_regions      = optional(list(string))
  }))
  default = []
}
