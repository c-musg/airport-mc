module "observability" {
  source = "../../../modules/observability/gcp"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  log_sinks           = var.log_sinks
  dashboards          = var.dashboards
  alert_policies      = var.alert_policies
  uptime_checks       = var.uptime_checks
}
