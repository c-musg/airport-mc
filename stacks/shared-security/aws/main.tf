module "kms" {
  source = "../../../modules/security/kms/aws"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  keys                = var.kms_keys
}

module "iam" {
  source = "../../../modules/security/iam/aws"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  permission_sets     = var.permission_sets
  roles               = var.iam_roles
}

module "dns" {
  source = "../../../modules/dns/route53"

  environment         = var.environment
  region              = var.aws_region
  cost_profile        = var.cost_profile
  enable_multi_region = var.enable_multi_region
  tags                = local.common_tags
  hosted_zones        = var.hosted_zones
  records             = var.dns_records
}

module "healthchecks" {
  source = "../../../modules/dns/healthchecks"

  environment = var.environment
  aws_region  = var.aws_region
  gcp_region  = "us-central1"
  targets     = var.health_check_targets
  labels      = local.common_tags
}
