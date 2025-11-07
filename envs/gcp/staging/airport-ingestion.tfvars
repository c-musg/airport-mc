project_id          = "airport-mc-staging"
region              = "us-central1"
environment         = "staging"
cost_profile        = "staging"
enable_multi_region = true
enable_managed_db   = false

labels = {
  org     = "airport-authority"
  project = "logistics"
}

pubsub_topics = [
  {
    name = "staging-airport-ingestion"
  }
]

pubsub_subscriptions = []
