module "s3" {
  source = "../../../modules/data/s3"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "tier" = "object" })
  buckets             = var.s3_buckets
}

module "dynamodb" {
  source = "../../../modules/data/dynamodb"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "tier" = "nosql" })
  tables              = var.dynamodb_tables
}

module "aurora" {
  count  = var.enable_managed_db ? 1 : 0
  source = "../../../modules/data/aurora"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "tier" = "rds" })
  clusters            = var.aurora_clusters
}
