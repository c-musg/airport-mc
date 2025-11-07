project_id          = "airport-mc-prod"
region              = "us-central1"
environment         = "prod"
cost_profile        = "prod"
enable_multi_region = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

key_rings = [
  {
    name     = "prod-airport-default"
    location = "us-central1"
    keys = [
      {
        name = "default"
      }
    ]
  }
]

service_accounts = []
bindings         = []

managed_zones = [
  {
    name     = "prod-airport"
    dns_name = "dev.airport.example.com."
  }
]

dns_records = []
health_check_targets = []
