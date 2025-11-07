output "api_gateway" {
  description = "API Gateway outputs for AWS APIs."
  value       = module.api_gateway
}

output "lambda_functions" {
  description = "Lambda API function outputs."
  value       = module.lambda_api
}

output "fargate_services" {
  description = "Fargate service outputs when enabled."
  value       = try(module.fargate_api[0], null)
}

output "waf_web_acl" {
  description = "WAF Web ACL details when enabled."
  value       = try(module.api_waf[0], null)
}
