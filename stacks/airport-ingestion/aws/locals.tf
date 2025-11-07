locals {
  stack_name    = "airport-ingestion-aws"
  common_tags   = merge(var.tags, { "stack" = local.stack_name })
  lambda_suffix = var.enable_multi_region ? "global" : var.aws_region
}
