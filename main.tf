provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-100200"

  # Ensure terraform will delete all versions of this bucket
  force_destroy = true

  # Prevent accidental deletion of this bucket when running terraform destroy
  lifecycle {
    prevent_destroy = true
  }

  # Enable versioning
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name  = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Uncomment and re-init
/*
terraform {
  # Partial config; pulls data from backend.hcl
  backend "s3" {
    key = "global/project1/terraform.tfstate"
  }
}
*/
