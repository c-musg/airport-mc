project_id          = "airport-mc-prod"
region              = "us-central1"
environment         = "prod"
cost_profile        = "prod"
enable_multi_region = true
enable_gke          = true
min_instances       = 2

labels = {
  org     = "airport-authority"
  project = "logistics"
}

cloud_run_services = [
  {
    name  = "prod-airport-api"
    image = "gcr.io/airport-mc-dev/dev-airport-api:latest"
  }
]

gke_clusters = []
