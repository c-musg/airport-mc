variable "project_id" {
  description = "Google Cloud project identifier where resources should be created."
  type        = string
}

variable "region" {
  description = "Google Cloud region for regional resources."
  type        = string
}

variable "environment" {
  description = "Short environment identifier (e.g. dev, staging, prod)."
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

variable "labels" {
  description = "Map of labels to apply to Google Cloud resources."
  type        = map(string)
  default     = {}
}

variable "service_accounts" {
  description = "Service account definitions."
  type = list(object({
    account_id   = string
    display_name = optional(string)
    description  = optional(string)
  }))
  default = []
}

variable "bindings" {
  description = "IAM bindings at project or resource level."
  type = list(object({
    role    = string
    members = list(string)
  }))
  default = []
}
