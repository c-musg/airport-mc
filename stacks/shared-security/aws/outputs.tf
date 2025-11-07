output "kms" {
  description = "KMS key outputs."
  value       = module.kms
}

output "iam" {
  description = "IAM role and permission set outputs."
  value       = module.iam
}

output "route53" {
  description = "Route53 outputs."
  value       = module.dns
}

output "healthchecks" {
  description = "Cross-cloud health check outputs."
  value       = module.healthchecks
}
