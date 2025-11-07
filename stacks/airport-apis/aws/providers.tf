provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        "environment" = var.environment
        "stack"       = "airport-apis"
        "component"   = "aws"
      },
      var.tags
    )
  }
}
