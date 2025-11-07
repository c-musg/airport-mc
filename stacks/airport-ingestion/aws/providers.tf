provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        "environment" = var.environment
        "stack"       = "airport-ingestion"
        "component"   = "aws"
      },
      var.tags
    )
  }
}
