# Backend configuration for main.tf
# Introduced to avoid manual work
# Pass in via -backend-config=backend.hcl

bucket = "example-client-state-12856136783124"
region = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt = true
