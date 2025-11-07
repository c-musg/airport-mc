output "s3_buckets" {
  description = "S3 bucket outputs for data stack."
  value       = module.s3
}

output "dynamodb_tables" {
  description = "DynamoDB outputs for data stack."
  value       = module.dynamodb
}

output "aurora_clusters" {
  description = "Aurora cluster outputs when enabled."
  value       = try(module.aurora[0], null)
}
