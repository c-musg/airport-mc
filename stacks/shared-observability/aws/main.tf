module "cloudwatch" {
  source = "../../../modules/observability/cloudwatch"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  log_groups          = var.log_groups
  alarms              = var.alarms
  dashboards          = var.dashboards
}
