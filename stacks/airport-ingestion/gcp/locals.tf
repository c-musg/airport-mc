locals {
  stack_name  = "airport-ingestion-gcp"
  common_labels = merge(
    {
      environment = var.environment
      stack       = "airport-ingestion"
      component   = "gcp"
    },
    var.labels
  )
}
