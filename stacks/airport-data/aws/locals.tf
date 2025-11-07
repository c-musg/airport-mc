locals {
  stack_name  = "airport-data-aws"
  common_tags = merge(var.tags, { "stack" = local.stack_name })
}
