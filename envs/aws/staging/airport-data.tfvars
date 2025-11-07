environment         = "staging"
aws_region          = "us-east-1"
cost_profile        = "staging"
enable_multi_region = true
enable_managed_db   = true
enable_analytics    = false

tags = {
  org     = "airport-authority"
  project = "logistics"
}

s3_buckets = [
  {
    name               = "staging-airport-ingestion"
    versioning_enabled = true
  }
]

dynamodb_tables = [
  {
    name       = "staging-airport-events"
    hash_key   = "event_id"
    attributes = [
      {
        name = "event_id"
        type = "S"
      }
    ]
  }
]

aurora_clusters = []
