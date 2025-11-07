module "cloud_run" {
  source = "../../../modules/compute/cloud_run"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  services            = var.cloud_run_services
}

module "gke" {
  count  = var.enable_gke ? 1 : 0
  source = "../../../modules/compute/gke"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  clusters            = var.gke_clusters
}

module "cloud_armor" {
  source = "../../../modules/security/armor"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.labels
  targets             = []
}
