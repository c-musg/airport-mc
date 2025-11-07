locals {
  stack_name = "shared-observability-gcp"
  labels = merge(
    {
      environment = var.environment
      stack       = "shared-observability"
      component   = "gcp"
    },
    var.labels
  )
}
