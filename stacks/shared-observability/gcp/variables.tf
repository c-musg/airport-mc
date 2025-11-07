variable "project_id" {
  description = "Google Cloud project identifier."
  type        = string
}

variable "region" {
  description = "Region for observability resources."
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
  description = "Enable multi-region telemetry resources."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply."
  type        = map(string)
  default     = {}
}

variable "log_sinks" {
  description = "Cloud Logging sink definitions."
  type        = list(map(any))
  default     = []
}

variable "dashboards" {
  description = "Cloud Monitoring dashboard definitions."
  type        = list(map(any))
  default     = []
}

variable "alert_policies" {
  description = "Alerting policy definitions."
  type        = list(map(any))
  default     = []
}

variable "uptime_checks" {
  description = "Uptime check definitions."
  type        = list(map(any))
  default     = []
}
