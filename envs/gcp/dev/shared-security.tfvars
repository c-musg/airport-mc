project_id          = "airport-mc-dev"
region              = "us-central1"
environment         = "dev"
cost_profile        = "dev"
enable_multi_region = false

labels = {
  org     = "airport-authority"
  project = "logistics"
}

key_rings = [
  {
    name     = "dev-airport-default"
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
    name     = "dev-airport"
    dns_name = "dev.airport.example.com."
  }
]

dns_records = []
health_check_targets = []
