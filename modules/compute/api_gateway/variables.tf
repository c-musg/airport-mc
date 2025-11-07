variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_waf" {
  description = "Whether to integrate the API with AWS WAF."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to API Gateway resources."
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Optional custom domain name to associate with the API."
  type        = string
  default     = ""
}

variable "routes" {
  description = "Route definitions (method + path) for integrating with backends."
  type = list(object({
    method        = string
    path          = string
    integration   = string
    authorizer_id = optional(string)
  }))
  default = []
}

variable "lambda_integrations" {
  description = "Lambda integration configuration keyed by route integration id."
  type = map(object({
    function_arn = string
    payload_format_version = optional(string)
    timeout_milliseconds   = optional(number)
  }))
  default = {}
}

variable "authorizers" {
  description = "Authorizer configuration definitions."
  type = list(object({
    name                = string
    type                = string
    identity_sources    = list(string)
    lambda_arn          = optional(string)
    jwt_issuer          = optional(string)
    jwt_audiences       = optional(list(string))
  }))
  default = []
}
