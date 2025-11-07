config {
  module = true
}

plugin "aws" {
  enabled = true
  version = "0.33.0"
  source  = "terraform-linters/tflint-ruleset-aws"
}

plugin "google" {
  enabled = true
  version = "0.22.0"
  source  = "terraform-linters/tflint-ruleset-google"
}
