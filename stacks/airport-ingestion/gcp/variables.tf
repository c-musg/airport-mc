variable "project_id" {
  description = "Google Cloud project identifier."
  type        = string
}

variable "region" {
  description = "Primary region for ingestion workloads."
  type        = string
}

variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod) controlling optional resources."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region routing and failover resources."
  type        = bool
  default     = false
}

variable "enable_managed_db" {
  description = "Toggle creation of managed Firestore/SQL instances."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels applied to Google Cloud resources."
  type        = map(string)
  default     = {}
}

variable "pubsub_topics" {
  description = "Pub/Sub topic definitions for event ingestion."
  type = list(object({
    name        = string
    kms_key     = optional(string)
    message_retention_duration = optional(string)
  }))
  default = []
}

variable "pubsub_subscriptions" {
  description = "Pub/Sub subscription definitions attached to ingestion topics."
  type = list(object({
    name                    = string
    topic                   = string
    ack_deadline_seconds    = optional(number)
    dead_letter_topic       = optional(string)
    max_delivery_attempts   = optional(number)
    push_endpoint           = optional(string)
    enable_message_ordering = optional(bool)
  }))
  default = []
}
