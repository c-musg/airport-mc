variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region for shared security resources."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region resources (e.g., multi-region KMS keys)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to shared resources."
  type        = map(string)
  default     = {}
}

variable "kms_keys" {
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

variable "iam_roles" {
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

variable "hosted_zones" {
  description = "Route53 hosted zone definitions."
  type = list(object({
    name             = string
    comment          = optional(string)
    private_zone     = optional(bool)
    vpc_associations = optional(list(map(string)))
  }))
  default = []
}

variable "dns_records" {
  description = "Route53 record definitions."
  type = list(object({
    zone_name     = string
    name          = string
    type          = string
    ttl           = optional(number)
    records       = optional(list(string))
    alias         = optional(map(string))
    health_check_id = optional(string)
  }))
  default = []
}

variable "health_check_targets" {
  description = "Targets for cross-cloud health checks."
  type        = list(any)
  default     = []
}
