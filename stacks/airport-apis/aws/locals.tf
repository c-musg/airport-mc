locals {
  stack_name  = "airport-apis-aws"
  common_tags = merge(var.tags, { "stack" = local.stack_name })
}
