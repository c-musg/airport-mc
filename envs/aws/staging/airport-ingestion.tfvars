environment         = "staging"
aws_region          = "us-east-1"
cost_profile        = "staging"
enable_multi_region = true
enable_managed_db   = false

tags = {
  org     = "airport-authority"
  project = "logistics"
}

ingestion_topics = [
  {
    name = "staging-airport-ingestion-events"
  }
]

ingestion_queues = []
