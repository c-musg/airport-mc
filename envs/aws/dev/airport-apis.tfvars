environment          = "dev"
aws_region           = "us-east-1"
cost_profile         = "dev"
enable_multi_region  = false
enable_waf_armor     = false
enable_fargate       = false
min_instances        = 0
api_domain_name      = ""

tags = {
  org     = "airport-authority"
  project = "logistics"
}

lambda_functions = [
  {
    name        = "dev-airport-api"
    runtime     = "python3.11"
    handler     = "handler.main"
    source_path = "../../applications/api"
  }
]

fargate_services = []
