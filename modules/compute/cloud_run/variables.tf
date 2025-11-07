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

variable "services" {
  description = "Definitions for Cloud Run services."
  type = list(object({
    name          = string
    image         = string
    cpu           = optional(string)
    memory        = optional(string)
    max_instances = optional(number)
    min_instances = optional(number)
    ingress       = optional(string)
    env           = optional(map(string))
  }))
  default = []
}

variable "service_accounts" {
  description = "Service accounts to bind to deployed services."
  type = list(object({
    name        = string
    description = optional(string)
    roles       = optional(list(string))
  }))
  default = []
}
