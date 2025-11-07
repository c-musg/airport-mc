project_id          = "airport-mc-staging"
region              = "us-central1"
environment         = "staging"
cost_profile        = "staging"
enable_multi_region = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

key_rings = [
  {
    name     = "staging-airport-default"
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
    name     = "staging-airport"
    dns_name = "dev.airport.example.com."
  }
]

dns_records = []
health_check_targets = []
