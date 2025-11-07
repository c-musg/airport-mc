environment          = "prod"
aws_region           = "us-east-1"
cost_profile         = "prod"
enable_multi_region  = true
enable_waf_armor     = true
enable_fargate       = true
min_instances        = 2
api_domain_name      = ""

tags = {
  org     = "airport-authority"
  project = "logistics"
}

lambda_functions = [
  {
    name        = "prod-airport-api"
    runtime     = "python3.11"
    handler     = "handler.main"
    source_path = "../../applications/api"
  }
]

fargate_services = []
