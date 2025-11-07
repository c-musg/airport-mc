environment          = "staging"
aws_region           = "us-east-1"
cost_profile         = "staging"
enable_multi_region  = true
enable_waf_armor     = true
enable_fargate       = false
min_instances        = 1
api_domain_name      = ""

tags = {
  org     = "airport-authority"
  project = "logistics"
}

lambda_functions = [
  {
    name        = "staging-airport-api"
    runtime     = "python3.11"
    handler     = "handler.main"
    source_path = "../../applications/api"
  }
]

fargate_services = []
