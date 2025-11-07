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

variable "hosted_zones" {
  description = "Hosted zone definitions."
  type = list(object({
    name                 = string
    comment              = optional(string)
    private_zone         = optional(bool)
    vpc_associations     = optional(list(map(string)))
    tags                 = optional(map(string))
  }))
  default = []
}

variable "records" {
  description = "DNS record definitions."
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
