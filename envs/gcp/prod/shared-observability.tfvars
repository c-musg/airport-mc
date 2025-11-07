project_id          = "airport-mc-prod"
region              = "us-central1"
environment         = "prod"
cost_profile        = "prod"
enable_multi_region = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

log_sinks      = []
dashboards     = []
alert_policies = []
uptime_checks  = []
