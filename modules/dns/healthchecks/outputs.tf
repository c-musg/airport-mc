output "route53_health_check_ids" {
  description = "Identifiers of Route53 health checks created by the module."
  value       = []
}

output "gcp_uptime_check_ids" {
  description = "Identifiers of Google Cloud uptime checks created by the module."
  value       = []
}
