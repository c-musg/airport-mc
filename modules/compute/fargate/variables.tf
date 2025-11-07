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

variable "services" {
  description = "Definitions for ECS services to create."
  type = list(object({
    name                  = string
    cpu                   = number
    memory                = number
    desired_count         = optional(number)
    container_image       = string
    container_port        = number
    command               = optional(list(string))
    environment           = optional(map(string))
    assign_public_ip      = optional(bool)
    platform_version      = optional(string)
    health_check_grace    = optional(number)
  }))
  default = []
}

variable "capacity_providers" {
  description = "Optional capacity provider strategy definitions."
  type = list(object({
    name   = string
    weight = optional(number)
    base   = optional(number)
  }))
  default = []
}
