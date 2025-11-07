environment         = "prod"
aws_region          = "us-east-1"
cost_profile        = "prod"
enable_multi_region = true

tags = {
  org     = "airport-authority"
  project = "logistics"
}

kms_keys = [
  {
    alias_name  = "alias/dev-airport-default"
    description = "Default encryption key for dev resources"
  }
]

permission_sets = []
iam_roles       = []

hosted_zones = [
  {
    name         = "dev.airport.example.com."
    private_zone = false
  }
]

dns_records = []
health_check_targets = []
