variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region used for the ingestion stack."
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
  description = "Toggle creation of managed database resources for ingestion state."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional AWS tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "ingestion_topics" {
  description = "SNS topic definitions for airline and IoT event sources."
  type = list(object({
    name        = string
    display_name = optional(string)
  }))
  default = []
}

variable "ingestion_queues" {
  description = "SQS queue definitions linked to ingestion topics."
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
