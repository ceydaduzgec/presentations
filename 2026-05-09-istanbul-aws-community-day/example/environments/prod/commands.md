1. Prod backend bucket'ını oluştur (bir kere):
cd example/environments/prod/vpc
terragrunt backend bootstrap


2. VPC oluştur:
cd example/environments/prod/vpc
terragrunt apply

3. EC2 oluştur (VPC apply bittikten sonra):
cd example/environments/prod/ec2
terragrunt apply