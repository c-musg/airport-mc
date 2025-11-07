environment         = "dev"
aws_region          = "us-east-1"
cost_profile        = "dev"
enable_multi_region = false
enable_managed_db   = false
enable_analytics    = false

tags = {
  org     = "airport-authority"
  project = "logistics"
}

s3_buckets = [
  {
    name               = "dev-airport-ingestion"
    versioning_enabled = true
  }
]

dynamodb_tables = [
  {
    name       = "dev-airport-events"
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
