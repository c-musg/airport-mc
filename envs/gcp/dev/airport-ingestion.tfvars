project_id          = "airport-mc-dev"
region              = "us-central1"
environment         = "dev"
cost_profile        = "dev"
enable_multi_region = false
enable_managed_db   = false

labels = {
  org     = "airport-authority"
  project = "logistics"
}

pubsub_topics = [
  {
    name = "dev-airport-ingestion"
  }
]

pubsub_subscriptions = []
