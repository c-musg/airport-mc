terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# TODO: Add DNS health check resources leveraging both AWS Route53 and Google Cloud Monitoring where required.
