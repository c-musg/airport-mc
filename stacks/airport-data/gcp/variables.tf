variable "project_id" {
  description = "Google Cloud project identifier."
  type        = string
}

variable "region" {
  description = "Primary region for data services."
  type        = string
}

variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "cost_profile" {
  description = "Cost profile flag (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "enable_multi_region" {
  description = "Enable multi-region replication."
  type        = bool
  default     = false
}

variable "enable_managed_db" {
  description = "Toggle managed database provisioning."
  type        = bool
  default     = false
}

variable "enable_analytics" {
  description = "Enable analytics tooling such as BigQuery."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels applied to data resources."
  type        = map(string)
  default     = {}
}

variable "gcs_buckets" {
  description = "GCS bucket definitions."
  type = list(object({
    name                = string
    location            = optional(string)
    storage_class       = optional(string)
    versioning_enabled  = optional(bool)
    lifecycle_rules     = optional(list(map(any)))
    retention_policy    = optional(map(any))
    kms_key_name        = optional(string)
  }))
  default = []
}

variable "firestore_indexes" {
  description = "Firestore composite indexes."
  type        = list(map(any))
  default     = []
}

variable "bigquery_datasets" {
  description = "BigQuery dataset definitions."
  type = list(object({
    dataset_id                 = string
    location                   = optional(string)
    default_table_expiration_ms = optional(number)
    access                     = optional(list(map(any)))
    kms_key_name               = optional(string)
  }))
  default = []
}
