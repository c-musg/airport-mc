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

variable "security_policies" {
  description = "Cloud Armor security policy definitions."
  type = list(object({
    name        = string
    description = optional(string)
    type        = optional(string)
    rules       = optional(list(map(any)))
  }))
  default = []
}

variable "targets" {
  description = "List of backend services or load balancers to attach policies to."
  type        = list(string)
  default     = []
}
