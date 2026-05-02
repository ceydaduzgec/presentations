1. Prod backend bucket'ını oluştur (bir kere):
cd example/environments/prod/vpc
terragrunt backend bootstrap

2. VPC oluştur:
cd example/environments/prod/vpc
terragrunt validate
terragrunt apply

3. EC2 oluştur (VPC apply bittikten sonra):
cd example/environments/prod/ec2
terragrunt validate
terragrunt apply


# Cache Cleanup
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} + && \
find . -type f -name ".terraform.lock.hcl" -exec rm -f {} + && \
find . -type f -name ".terragrunt-lock.hcl" -exec rm -f {} +