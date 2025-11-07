project_id          = "airport-mc-staging"
region              = "us-central1"
environment         = "staging"
cost_profile        = "staging"
enable_multi_region = true
enable_managed_db   = true
enable_analytics    = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

gcs_buckets = [
  {
    name               = "staging-airport-ingestion-gcp"
    versioning_enabled = true
  }
]

firestore_indexes   = []
bigquery_datasets   = []
