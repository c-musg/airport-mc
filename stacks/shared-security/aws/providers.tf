provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        "environment" = var.environment
        "stack"       = "shared-security"
        "component"   = "aws"
      },
      var.tags
    )
  }
}
