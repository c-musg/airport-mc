variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region used for the API stack."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region features for the API layer."
  type        = bool
  default     = false
}

variable "enable_waf_armor" {
  description = "Toggle AWS WAF association for ingress."
  type        = bool
  default     = false
}

variable "min_instances" {
  description = "Desired minimum number of compute instances (Lambda provisioned concurrency or ECS tasks)."
  type        = number
  default     = 0
}

variable "enable_fargate" {
  description = "Enable ECS Fargate backing for APIs (otherwise Lambda only)."
  type        = bool
  default     = false
}

variable "lambda_functions" {
  description = "Definitions for API Lambda functions."
  type = list(object({
    name        = string
    runtime     = string
    handler     = string
    source_path = string
    memory_mb   = optional(number)
    timeout_s   = optional(number)
    environment = optional(map(string))
  }))
  default = []
}

variable "fargate_services" {
  description = "Definitions for ECS Fargate services backing the APIs."
  type = list(object({
    name                 = string
    cpu                  = number
    memory               = number
    desired_count        = optional(number)
    container_image      = string
    container_port       = number
    health_check_path    = optional(string)
    assign_public_ip     = optional(bool)
  }))
  default = []
}

variable "api_domain_name" {
  description = "Custom domain name for the API Gateway."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional AWS tags to apply."
  type        = map(string)
  default     = {}
}
