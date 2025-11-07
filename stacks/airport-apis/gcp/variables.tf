variable "project_id" {
  description = "Google Cloud project identifier."
  type        = string
}

variable "region" {
  description = "Primary region for API workloads."
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
  description = "Enable multi-region deployment for Cloud Run or GKE."
  type        = bool
  default     = false
}

variable "min_instances" {
  description = "Minimum instances for Cloud Run services."
  type        = number
  default     = 0
}

variable "enable_gke" {
  description = "Toggle provisioning of a GKE cluster for API workloads."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to API resources."
  type        = map(string)
  default     = {}
}

variable "cloud_run_services" {
  description = "Cloud Run service definitions."
  type = list(object({
    name                = string
    image               = string
    max_instances       = optional(number)
    min_instances       = optional(number)
    concurrency         = optional(number)
    ingress             = optional(string)
    vpc_connector       = optional(string)
    env                 = optional(map(string))
  }))
  default = []
}

variable "gke_clusters" {
  description = "GKE cluster definitions."
  type = list(object({
    name                 = string
    location             = string
    network              = optional(string)
    subnetwork           = optional(string)
    release_channel      = optional(string)
    enable_autopilot     = optional(bool)
  }))
  default = []
}
