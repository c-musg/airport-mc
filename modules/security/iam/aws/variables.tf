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

variable "permission_sets" {
  description = "IAM Identity Center permission set definitions."
  type = list(object({
    name             = string
    description      = optional(string)
    managed_policies = optional(list(string))
    inline_policy    = optional(string)
    session_duration = optional(string)
  }))
  default = []
}

variable "roles" {
  description = "IAM role definitions."
  type = list(object({
    name                  = string
    description           = optional(string)
    assume_role_policy    = string
    managed_policy_arns   = optional(list(string))
    inline_policies       = optional(map(string))
    max_session_duration  = optional(number)
    permissions_boundary  = optional(string)
  }))
  default = []
}
