provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "example-client-state-12856136783124"

  # Prevent accidental deletion of this S3 bucket when running terraform destroy
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
  name  = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


# Configure terraform to store state for this project in S3
terraform {
  backend "s3" {
    bucket = "example-client-state-12856136783124"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}
