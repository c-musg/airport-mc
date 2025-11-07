module "kms" {
  source = "../../../modules/security/kms/gcp"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  key_rings           = var.key_rings
}

module "iam" {
  source = "../../../modules/security/iam/gcp"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  service_accounts    = var.service_accounts
  bindings            = var.bindings
}

module "dns" {
  source = "../../../modules/dns/cloud_dns"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  managed_zones       = var.managed_zones
  records             = var.dns_records
}

module "healthchecks" {
  source = "../../../modules/dns/healthchecks"

  environment = var.environment
  aws_region  = "us-east-1"
  gcp_region  = var.region
  targets     = var.health_check_targets
  labels      = local.labels
}
