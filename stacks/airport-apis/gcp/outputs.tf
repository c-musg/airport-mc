output "cloud_run" {
  description = "Cloud Run service outputs."
  value       = module.cloud_run
}

output "gke" {
  description = "GKE clusters when enabled."
  value       = try(module.gke[0], null)
}

output "cloud_armor" {
  description = "Cloud Armor policy outputs."
  value       = module.cloud_armor
}
