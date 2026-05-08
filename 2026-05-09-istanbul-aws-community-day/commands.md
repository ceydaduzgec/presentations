export AWS_PROFILE=digitalops

# Apply Commands
cd example/environments/test/vpc
terragrunt backend bootstrap
terragrunt apply

# Cache Cleanup
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} + && \
find . -type f -name ".terraform.lock.hcl" -exec rm -f {} + && \
find . -type f -name ".terragrunt-lock.hcl" -exec rm -f {} +

# Import Example
cd 2026-05-09-istanbul-aws-community-day/import
terraform init
terraform plan -generate-config-out="generated.tf"
