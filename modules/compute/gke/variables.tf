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

variable "clusters" {
  description = "GKE cluster definitions."
  type = list(object({
    name                 = string
    location             = string
    network              = optional(string)
    subnetwork           = optional(string)
    release_channel      = optional(string)
    enable_autopilot     = optional(bool)
    enable_workload_identity = optional(bool)
  }))
  default = []
}
