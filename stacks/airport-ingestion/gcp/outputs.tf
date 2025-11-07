output "network" {
  description = "VPC outputs for the GCP ingestion stack."
  value       = module.network
}

output "topics" {
  description = "Pub/Sub topic outputs."
  value       = module.messaging
}

output "services" {
  description = "Cloud Run service outputs."
  value       = module.cloud_run_ingestion
}

output "datastore" {
  description = "Firestore outputs."
  value       = module.firestore
}

output "bucket" {
  description = "Ingestion bucket outputs."
  value       = module.ingestion_bucket
}
