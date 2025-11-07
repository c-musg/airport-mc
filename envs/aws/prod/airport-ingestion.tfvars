environment         = "prod"
aws_region          = "us-east-1"
cost_profile        = "prod"
enable_multi_region = true
enable_managed_db   = true

tags = {
  org     = "airport-authority"
  project = "logistics"
}

ingestion_topics = [
  {
    name = "prod-airport-ingestion-events"
  }
]

ingestion_queues = []
