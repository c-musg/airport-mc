package cost_profile

deny[msg] {
  input.resource_type == "aws_db_instance"
  input.values.cost_profile == "dev"
  msg = sprintf("Managed databases must be disabled when cost_profile=dev (%s)", [input.resource_address])
}

deny[msg] {
  input.resource_type == "google_sql_database_instance"
  input.values.cost_profile == "dev"
  msg = sprintf("Managed databases must be disabled when cost_profile=dev (%s)", [input.resource_address])
}
