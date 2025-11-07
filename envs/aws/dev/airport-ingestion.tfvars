environment         = "dev"
aws_region          = "us-east-1"
cost_profile        = "dev"
enable_multi_region = false
enable_managed_db   = false

tags = {
  org     = "airport-authority"
  project = "logistics"
}

ingestion_topics = [
  {
    name = "dev-airport-ingestion-events"
  }
]

ingestion_queues = []
