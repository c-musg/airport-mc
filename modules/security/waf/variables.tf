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

variable "scope" {
  description = "Scope of the WAF (REGIONAL or CLOUDFRONT)."
  type        = string
  default     = "REGIONAL"
}

variable "managed_rule_groups" {
  description = "Managed rule groups to enable."
  type = list(object({
    name        = string
    vendor_name = string
    priority    = number
    override_action = optional(string)
  }))
  default = []
}

variable "custom_rules" {
  description = "Custom rule statements."
  type = list(object({
    name     = string
    priority = number
    action   = string
    statement = map(any)
  }))
  default = []
}

variable "associations" {
  description = "Resources (ARNs) that the Web ACL should associate with."
  type        = list(string)
  default     = []
}
