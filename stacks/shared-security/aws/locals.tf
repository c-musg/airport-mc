locals {
  stack_name  = "shared-security-aws"
  common_tags = merge(var.tags, { "stack" = local.stack_name })
}
