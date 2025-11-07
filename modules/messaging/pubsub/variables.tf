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

variable "topics" {
  description = "Definitions for Pub/Sub topics."
  type = list(object({
    name        = string
    kms_key     = optional(string)
    message_retention_duration = optional(string)
    schema      = optional(string)
  }))
  default = []
}

variable "subscriptions" {
  description = "Definitions for Pub/Sub subscriptions."
  type = list(object({
    name                     = string
    topic                    = string
    ack_deadline_seconds     = optional(number)
    dead_letter_topic        = optional(string)
    max_delivery_attempts    = optional(number)
    push_endpoint            = optional(string)
    enable_message_ordering  = optional(bool)
  }))
  default = []
}
