module "network" {
  source = "../../../modules/network/aws"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
}

module "messaging" {
  source = "../../../modules/messaging/sns_sqs"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  topics              = var.ingestion_topics
  queues              = var.ingestion_queues
}

module "lambda_ingestion" {
  source = "../../../modules/compute/lambda"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "function" = "event_ingestion" })

  depends_on = [
    module.network,
    module.messaging,
  ]
}

module "ingestion_store" {
  source = "../../../modules/data/dynamodb"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "tier" = "data" })
}

module "ingestion_bucket" {
  source = "../../../modules/data/s3"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "tier" = "object" })
}
