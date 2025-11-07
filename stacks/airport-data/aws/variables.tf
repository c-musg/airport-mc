variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region for data services."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region replication features."
  type        = bool
  default     = false
}

variable "enable_managed_db" {
  description = "Toggle managed database provisioning (Aurora)."
  type        = bool
  default     = false
}

variable "enable_analytics" {
  description = "Enable analytics tooling (Athena/Glue/OpenSearch)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional AWS tags to apply."
  type        = map(string)
  default     = {}
}

variable "s3_buckets" {
  description = "S3 bucket definitions."
  type = list(object({
    name                     = string
    lifecycle_rules          = optional(list(map(any)))
    replication_configuration = optional(map(any))
  }))
  default = []
}

variable "dynamodb_tables" {
  description = "DynamoDB table definitions."
  type = list(object({
    name             = string
    billing_mode     = optional(string)
    hash_key         = string
    range_key        = optional(string)
    attributes       = list(map(string))
    global_secondary_indexes = optional(list(map(any)))
  }))
  default = []
}

variable "aurora_clusters" {
  description = "Aurora cluster definitions."
  type = list(object({
    name             = string
    engine           = string
    engine_mode      = optional(string)
    instance_class   = optional(string)
    kms_key_arn      = optional(string)
    backup_retention = optional(number)
  }))
  default = []
}
