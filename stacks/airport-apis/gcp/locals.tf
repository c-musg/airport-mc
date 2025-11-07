locals {
  stack_name = "airport-apis-gcp"
  labels = merge(
    {
      environment = var.environment
      stack       = "airport-apis"
      component   = "gcp"
    },
    var.labels
  )
}
