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

variable "keys" {
  description = "KMS key definitions."
  type = list(object({
    alias_name           = string
    description          = optional(string)
    deletion_window_days = optional(number)
    multi_region         = optional(bool)
    key_usage            = optional(string)
    policy_json          = optional(string)
  }))
  default = []
}
