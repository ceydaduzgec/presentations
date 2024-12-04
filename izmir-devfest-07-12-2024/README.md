# Delete cache
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
find . -type f -name ".terraform.lock.hcl" -exec rm -f {} \;
find . -type d -name ".terraform" -exec rm -rf {} \;

# Terraformer
terraformer import aws --resources=vpc,subnet --regions=eu-west-1 --profile=sufledev  


# Initilize and Apply
terragrunt init
terragrunt apply

# Create new private subnet to existing VPC
aws ec2 create-subnet \
    --vpc-id vpc-02ef1a763b20a95bc \
    --cidr-block 10.30.21.0/24 \
    --availability-zone eu-west-1b \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Private-Subnet-3},{Key=Owner,Value=Ceyda}]'

# Get State
terragrunt state list
-> private subnet is missing

# Import by Config-driven
terragrunt plan -generate-config-out="generated.tf"

# Import by hand:
terragrunt import "aws_subnet.private[1]" subnet-07a4a50cb38cae195

1.0.5
1.10