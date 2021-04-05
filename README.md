# Terraform remote state with AWS S3 and DynamoDB

### Create required resources

1. Clone the repository locally
2. Configure aws-cli by running `aws configure`
4. Initialize a new project with `terraform init`
5. Inspect changes with `trerraform plan`
6. Apply changes with `terraform apply --auto-approve`

These steps will create the S3 bucket and DynamoDB table required in order to migrate the locally stored state located in `.terraform.tfstate`

### Migrate the local state

1. Uncomment the `terraform` block which instructs what backend terraform should use for state
2. Re-initialize the project with `terraform init`. Required when re-configuring the backend

### Verification
1. Ensure a `terraform.tfstate` file is created in the S3 bucket
2. Navigate to DynamoDb > Tables > `terraform-locks` > Items
3. Run `terraform plan` and refresh the items
4. Observe a new item created - terraform has acquired a lock for the current execution
5. Refresh again once `terraform plan` is complete and the item will be removed - the lock is released
