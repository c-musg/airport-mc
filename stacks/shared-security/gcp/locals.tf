locals {
  stack_name = "shared-security-gcp"
  labels = merge(
    {
      environment = var.environment
      stack       = "shared-security"
      component   = "gcp"
    },
    var.labels
  )
}
