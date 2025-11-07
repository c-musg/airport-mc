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

variable "topics" {
  description = "Definitions for SNS topics to provision."
  type = list(object({
    name         = string
    display_name = optional(string)
    fifo         = optional(bool)
    kms_key_id   = optional(string)
  }))
  default = []
}

variable "queues" {
  description = "Definitions for SQS queues to provision and subscribe."
  type = list(object({
    name                       = string
    fifo                       = optional(bool)
    visibility_timeout_seconds = optional(number)
    message_retention_seconds  = optional(number)
    dead_letter_target_arn     = optional(string)
    max_receive_count          = optional(number)
  }))
  default = []
}
