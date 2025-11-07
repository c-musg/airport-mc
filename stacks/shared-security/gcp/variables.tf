variable "project_id" {
  description = "Google Cloud project identifier."
  type        = string
}

variable "region" {
  description = "Primary region for shared security resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region resources."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to shared security resources."
  type        = map(string)
  default     = {}
}

variable "key_rings" {
  description = "KMS key ring definitions."
  type = list(object({
    name     = string
    location = string
    keys = list(object({
      name             = string
      purpose          = optional(string)
      rotation_period  = optional(string)
      protection_level = optional(string)
      labels           = optional(map(string))
    }))
  }))
  default = []
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
  description = "Project-level IAM bindings."
  type = list(object({
    role    = string
    members = list(string)
  }))
  default = []
}

variable "managed_zones" {
  description = "Cloud DNS managed zone definitions."
  type = list(object({
    name        = string
    dns_name    = string
    description = optional(string)
    visibility  = optional(string)
  }))
  default = []
}

variable "dns_records" {
  description = "Cloud DNS record sets."
  type = list(object({
    managed_zone = string
    name         = string
    type         = string
    ttl          = optional(number)
    rrdatas      = optional(list(string))
    routing_policy = optional(map(any))
  }))
  default = []
}

variable "health_check_targets" {
  description = "Targets for cross-cloud health checks."
  type        = list(any)
  default     = []
}
