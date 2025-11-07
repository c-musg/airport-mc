locals {
  stack_name  = "shared-observability-aws"
  common_tags = merge(var.tags, { "stack" = local.stack_name })
}
