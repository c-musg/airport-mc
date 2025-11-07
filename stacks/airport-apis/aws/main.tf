module "api_gateway" {
  source = "../../../modules/compute/api_gateway"

  environment  = var.environment
  region       = var.aws_region
  cost_profile = var.cost_profile
  enable_waf   = var.enable_waf_armor
  domain_name  = var.api_domain_name
  tags         = local.common_tags

  # TODO: Populate routes and authorizers when handlers are implemented.
}

module "lambda_api" {
  source = "../../../modules/compute/lambda"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "runtime" = "lambda" })
  functions           = var.lambda_functions
}

module "fargate_api" {
  count = var.enable_fargate ? 1 : 0
  source = "../../../modules/compute/fargate"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = merge(local.common_tags, { "runtime" = "fargate" })
  services            = var.fargate_services
}

module "api_waf" {
  count = var.enable_waf_armor ? 1 : 0
  source = "../../../modules/security/waf"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  associations        = []
}
