project_id          = "airport-mc-staging"
region              = "us-central1"
environment         = "staging"
cost_profile        = "staging"
enable_multi_region = true

labels = {
  org     = "airport-authority"
  project = "logistics"
}

log_sinks      = []
dashboards     = []
alert_policies = []
uptime_checks  = []
