module "gcs" {
  source = "../../../modules/data/gcs"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.labels, { tier = "object" })
  buckets             = var.gcs_buckets
}

module "firestore" {
  count  = var.enable_managed_db ? 1 : 0
  source = "../../../modules/data/firestore"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.labels, { tier = "document" })
  indexes             = var.firestore_indexes
}

module "bigquery" {
  count  = var.enable_analytics ? 1 : 0
  source = "../../../modules/data/bigquery"

  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  labels              = merge(local.labels, { tier = "analytics" })
  datasets            = var.bigquery_datasets
}
