# Backend configuration for main.tf
# Introduced to avoid manual work
# Pass in with -backend-config=backend.hcl

bucket = "terraform-state-" # Replace with S3 bucket output
region = "us-east-1"
dynamodb_table = "terraform-state-lock"
encrypt = true
