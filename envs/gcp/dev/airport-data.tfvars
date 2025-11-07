project_id          = "airport-mc-dev"
region              = "us-central1"
environment         = "dev"
cost_profile        = "dev"
enable_multi_region = false
enable_managed_db   = false
enable_analytics    = false

labels = {
  org     = "airport-authority"
  project = "logistics"
}

gcs_buckets = [
  {
    name               = "dev-airport-ingestion-gcp"
    versioning_enabled = true
  }
]

firestore_indexes   = []
bigquery_datasets   = []
