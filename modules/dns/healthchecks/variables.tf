variable "environment" {
  description = "Short environment identifier (e.g. dev, staging, prod)."
  type        = string
}

variable "aws_region" {
  description = "Primary AWS region for Route53 health checks."
  type        = string
}

variable "gcp_region" {
  description = "Primary Google Cloud region for Cloud Monitoring resources."
  type        = string
}

variable "targets" {
  description = "List of endpoint definitions to health check across clouds."
  type = list(object({
    name        = string
    description = optional(string)
    protocol    = string
    host        = string
    path        = optional(string)
    port        = optional(number)
  }))
  default = []
}

variable "labels" {
  description = "Generic labels/tags to apply to created resources."
  type        = map(string)
  default     = {}
}
