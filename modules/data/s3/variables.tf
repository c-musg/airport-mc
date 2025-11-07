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

variable "buckets" {
  description = "Bucket configuration blocks."
  type = list(object({
    name                     = string
    versioning_enabled       = optional(bool)
    lifecycle_rules          = optional(list(map(any)))
    replication_configuration = optional(map(any))
    kms_key_arn              = optional(string)
  }))
  default = []
}
