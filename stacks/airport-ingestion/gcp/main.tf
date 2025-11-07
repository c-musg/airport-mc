module "network" {
  source = "../../../modules/network/gcp"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.common_labels
}

module "messaging" {
  source = "../../../modules/messaging/pubsub"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = local.common_labels
  topics              = var.pubsub_topics
  subscriptions       = var.pubsub_subscriptions
}

module "cloud_run_ingestion" {
  source = "../../../modules/compute/cloud_run"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.common_labels, { workload = "ingestion" })

  depends_on = [
    module.network,
    module.messaging,
  ]
}

module "firestore" {
  source = "../../../modules/data/firestore"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.common_labels, { tier = "data" })
}

module "ingestion_bucket" {
  source = "../../../modules/data/gcs"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.common_labels, { tier = "object" })
}
