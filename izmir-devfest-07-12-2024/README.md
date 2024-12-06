# 02-terraform-config

## Initilize Terraform
terraform init

## Provider Version
terraform state replace-provider registry.terraform.io/-/aws hashicorp/aws

# Terraformer
https://github.com/GoogleCloudPlatform/terraformer

terraformer import aws --resources=vpc,subnet --regions=eu-west-1 --profile=sufledev  
terraformer import aws --resources=ec2_instance --regions=eu-west-1 --profile=sufledev 

# 02-terraformer-backup
If step 2 doesn't work out, this is the output

# 03-terraformer-apply

## Initilize Terraform
terraform init

## Terraform Plan
terraform plan

## Import by hand:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
`terraform import aws_instance.web i-12345678`

terraform import "aws_instance.tfer--i-070cd2e18bbe9c2b3_devfest-test-devfest" i-05c6f1b076bf76596 

## Get State
terraform state list

## Apply Terraform
terraform apply

# 04-terraform-modules
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest

## Initilize Terragrunt
terraform init

## Import by hand:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
`terraform import aws_instance.web i-12345678`

terraform import "module.vpc.aws_vpc.this[0]" vpc-XXXXXX
terraform import "module.ec2_instance.aws_instance.this[0]" i-XXXXX

## Apply Terraform
terraform apply

# 05-terragrunt

## Initilize Terragrunt
terragrunt init

## Apply Terragrunt
terragrunt apply


------------------------------------------

# Delete cache
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
find . -type f -name ".terraform.lock.hcl" -exec rm -f {} \;
find . -type d -name ".terraform" -exec rm -rf {} \;


## Create S3 Bucket
aws s3api create-bucket \
    --bucket 01-devfest-terraform-state \
    --region eu-west-1 \
    --create-bucket-configuration LocationConstraint=eu-west-1
aws s3api create-bucket \
    --bucket 02-devfest-terraform-state \
    --region eu-west-1 \
    --create-bucket-configuration LocationConstraint=eu-west-1
aws s3api create-bucket \
    --bucket 03-devfest-terraform-state \
    --region eu-west-1 \
    --create-bucket-configuration LocationConstraint=eu-west-1
aws s3api create-bucket \
    --bucket 04-devfest-terraform-state \
    --region eu-west-1 \
    --create-bucket-configuration LocationConstraint=eu-west-1

# Empty Buckets
aws s3 rm s3://01-devfest-terraform-state --recursive
aws s3 rm s3://02-devfest-terraform-state --recursive
aws s3 rm s3://03-devfest-terraform-state --recursive
aws s3 rm s3://04-devfest-terraform-state --recursive
aws s3 rm s3://devfest-test-terragrunt-state --recursive

# Delete Buckets
aws s3 rb s3://devfest-01-terraform-state
aws s3 rb s3://devfest-02-terraform-state
aws s3 rb s3://devfest-03-terraform-state
aws s3 rb s3://devfest-04-terraform-state
aws s3 rb s3://devfest-05-terraform-state
aws s3 rb s3://devfest-test-terragrunt-state

## Create new private subnet to existing VPC
aws ec2 create-subnet \
    --vpc-id vpc-02ef1a763b20a95bc \
    --cidr-block 10.30.21.0/24 \
    --availability-zone eu-west-1b \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Private-Subnet-3},{Key=Owner,Value=Ceyda}]'
