output "gcs_buckets" {
  description = "GCS bucket outputs."
  value       = module.gcs
}

output "firestore" {
  description = "Firestore outputs when enabled."
  value       = try(module.firestore[0], null)
}

output "bigquery" {
  description = "BigQuery dataset outputs when analytics is enabled."
  value       = try(module.bigquery[0], null)
}
