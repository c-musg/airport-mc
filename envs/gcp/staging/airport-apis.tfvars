project_id          = "airport-mc-staging"
region              = "us-central1"
environment         = "staging"
cost_profile        = "staging"
enable_multi_region = true
enable_gke          = false
min_instances       = 1

labels = {
  org     = "airport-authority"
  project = "logistics"
}

cloud_run_services = [
  {
    name  = "staging-airport-api"
    image = "gcr.io/airport-mc-staging/dev-airport-api:latest"
  }
]

gke_clusters = []
