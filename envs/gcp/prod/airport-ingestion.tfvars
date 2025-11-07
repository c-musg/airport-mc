project_id          = "airport-mc-prod"
region              = "us-central1"
environment         = "prod"
cost_profile        = "prod"
enable_multi_region = true
enable_managed_db   = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

pubsub_topics = [
  {
    name = "prod-airport-ingestion"
  }
]

pubsub_subscriptions = []
