# Terraform remote state with AWS S3 and DynamoDB

## To create:

### 1. Create required resources

1. Clone the repository locally
2. Configure aws-cli by running `aws configure`
4. Initialize a new project with `terraform init`
5. Inspect changes with `trerraform plan`
6. Apply changes with `terraform apply --auto-approve`

These steps will create the S3 bucket and DynamoDB table required in order to migrate the locally stored state in `.terraform.tfstate`

### 2. Migrate to remote state

1. Uncomment the `terraform` block in `main.tf` which instructs what backend terraform should use for state
3. Copy the newly created S3 bucket name from the console output and reference it in `backend.hcl`
2. Re-initialize the project and pass in backend configuration with `terraform init -backend-config=backend.hcl`. Required when re-configuring the backend

### 3. Verification
1. Ensure a `terraform.tfstate` file is created in the S3 bucket
2. Navigate to DynamoDB > Tables > `terraform-locks` > Items
3. Run `terraform plan` and refresh the items
4. Observe a new item created - terraform has acquired a lock for the current execution
5. Refresh again once `terraform plan` is complete and the item will be removed - the lock is released

### 4. Next steps
Once our resources are configured we can now use the same bucket across different projects to store terraform state.

1. Copy `backend.hcl` to another project
2. Copy the `terraform` block containing the backend configuration and edit the key. (key must be unique across all projects using the same bucket)
3. Re-initialize the project and pass in backend configuration with `terraform init -backend-config=backend.hcl`. Required when re-configuring the backend

## To destroy:

### 1. Migrate to local state

1. Comment out the `terraform` block in `main.tf`. As no other option is specified terraform will default to storing state locally
2. Re-initialize the project with `terraform init`. Required when re-configuring the backend

### 2. Destroy resources
1. Comment out the `lifecycle` block for the S3 bucket in `main.tf` (otherwise terraform will fail to remove the bucket)
2. Run `terraform destroy`

### 3. Verification
1. Ensure the S3 bucket and DynamoDB table do not exist
