project_id          = "airport-mc-prod"
region              = "us-central1"
environment         = "prod"
cost_profile        = "prod"
enable_multi_region = true
enable_managed_db   = true
enable_analytics    = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

gcs_buckets = [
  {
    name               = "prod-airport-ingestion-gcp"
    versioning_enabled = true
  }
]

firestore_indexes   = []
bigquery_datasets   = []
