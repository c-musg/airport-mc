output "kms" {
  description = "Google Cloud KMS outputs."
  value       = module.kms
}

output "iam" {
  description = "Google Cloud IAM outputs."
  value       = module.iam
}

output "cloud_dns" {
  description = "Cloud DNS outputs."
  value       = module.dns
}

output "healthchecks" {
  description = "Cross-cloud health check outputs."
  value       = module.healthchecks
}
