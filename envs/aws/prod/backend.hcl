bucket         = "airport-mc-terraform-prod"
dynamodb_table = "airport-mc-terraform-locks-prod"
encrypt        = true
region         = "us-east-1"
# State key is supplied per stack via Makefile init flags.
