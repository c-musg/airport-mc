bucket         = "airport-mc-terraform-staging"
dynamodb_table = "airport-mc-terraform-locks-staging"
encrypt        = true
region         = "us-east-1"
# State key is supplied per stack via Makefile init flags.
