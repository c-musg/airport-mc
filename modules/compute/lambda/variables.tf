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

variable "functions" {
  description = "Collection of Lambda function definitions to provision."
  type = list(object({
    name                     = string
    runtime                  = string
    handler                  = string
    source_path              = string
    memory_size              = optional(number)
    timeout                  = optional(number)
    environment              = optional(map(string))
    reserved_concurrent_executions = optional(number)
    provisioned_concurrency  = optional(number)
  }))
  default = []
}

variable "layers" {
  description = "Optional Lambda layers to publish and attach."
  type = list(object({
    name        = string
    description = optional(string)
    source_path = string
  }))
  default = []
}

variable "log_retention_days" {
  description = "CloudWatch log group retention period."
  type        = number
  default     = 3
}
