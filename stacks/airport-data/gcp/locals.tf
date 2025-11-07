locals {
  stack_name = "airport-data-gcp"
  labels = merge(
    {
      environment = var.environment
      stack       = "airport-data"
      component   = "gcp"
    },
    var.labels
  )
}
