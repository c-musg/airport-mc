project_id          = "airport-mc-dev"
region              = "us-central1"
environment         = "dev"
cost_profile        = "dev"
enable_multi_region = false
enable_gke          = false
min_instances       = 0

labels = {
  org     = "airport-authority"
  project = "logistics"
}

cloud_run_services = [
  {
    name  = "dev-airport-api"
    image = "gcr.io/airport-mc-dev/dev-airport-api:latest"
  }
]

gke_clusters = []
