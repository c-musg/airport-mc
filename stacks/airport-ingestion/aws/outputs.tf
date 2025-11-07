output "ingestion_network" {
  description = "Network attributes for AWS ingestion stack."
  value       = module.network
}

output "queues" {
  description = "Messaging resources for ingestion."
  value       = module.messaging
}

output "lambda_functions" {
  description = "Lambda ingestion function metadata."
  value       = module.lambda_ingestion
}

output "datastore" {
  description = "Primary DynamoDB ingestion table outputs."
  value       = module.ingestion_store
}

output "object_store" {
  description = "S3 bucket outputs for ingestion artifacts."
  value       = module.ingestion_bucket
}
