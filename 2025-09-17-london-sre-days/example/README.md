# Terragrunt AWS Infrastructure

This repository demonstrates how to use Terragrunt to manage AWS infrastructure across multiple environments (prod/test) with reusable Terraform modules.

## Project Structure

```
.
├── README.md
├── aws/
│   ├── prod/                    # Production environment
│   │   ├── common_vars.yaml     # Environment-specific variables
│   │   ├── terragrunt.hcl       # Environment-level configuration
│   │   ├── ec2/                 # EC2 instance configuration
│   │   └── vpc/                 # VPC configuration
│   └── test/                    # Test environment (same structure)
└── modules/                     # Reusable Terraform modules
    ├── terraform-aws-ec2-instance/
    └── terraform-aws-vpc/
```

## Prerequisites

- AWS CLI installed and configured
- Terraform installed
- Terragrunt installed

## Getting Started

Follow these steps to deploy the infrastructure:

### 1. Setup: Add your Cloud Provider account credentials

#### Option A: AWS CLI Profile (Recommended)
1. Configure your AWS credentials using AWS CLI:
   ```bash
   aws configure --profile your-profile-name
   ```
   
2. Update the profile name in the Terragrunt configuration files:
   - Edit `aws/prod/terragrunt.hcl` (line 5 and 15)
   - Edit `aws/test/terragrunt.hcl` (line 5 and 15)
   
   Replace `sufledev` with your AWS profile name:
   ```hcl
   provider "aws" {
     region  = "eu-west-1"
     profile = "your-profile-name"  # <-- Change this
   }
   ```

#### Option B: Environment Variables
Alternatively, you can use environment variables and remove the `profile` parameter:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="eu-west-1"
```

### 2. Install: Install Terragrunt

```bash
# macOS
brew install terragrunt

# Linux
curl -Lo terragrunt https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin/
```

### 3. Customize: Update configuration values

Before deploying, customize the following values for your environment:

#### Update S3 Bucket Name
In `aws/prod/terragrunt.hcl` and `aws/test/terragrunt.hcl`, update the S3 bucket name:
```hcl
config = {
  bucket  = "your-unique-bucket-name-terragrunt-state"  # <-- Change this
  # ... rest of config
}
```

#### Update Common Variables
In `aws/prod/common_vars.yaml` and `aws/test/common_vars.yaml`:
```yaml
namespace: your-project-name     # <-- Change this
environment: prod               # Keep as is for prod, change to 'test' for test env

tags:
  Namespace: your-project-name  # <-- Change this
  Environment: prod
  Terraform: true
  Owner: YourName              # <-- Change this
```

### 4. Create: Your terragrunt.hcl files are ready

The repository already includes properly structured `terragrunt.hcl` files that:
- Reference reusable Terraform modules
- Configure remote state management
- Set up provider configurations
- Handle dependencies between resources

### 5. Run: Execute terragrunt plan

Navigate to the environment you want to deploy and run plan:

```bash
# For production environment
cd aws/prod
terragrunt run-all plan

# Or plan individual resources
cd aws/prod/vpc
terragrunt plan

cd aws/prod/ec2
terragrunt plan
```

### 6. Deploy: Execute terragrunt apply

Deploy the infrastructure:

```bash
# Deploy all resources in the environment
cd aws/prod
terragrunt run-all apply

# Or deploy individual resources (note: VPC must be deployed before EC2)
cd aws/prod/vpc
terragrunt apply

cd aws/prod/ec2
terragrunt apply
```

## Resource Dependencies

The infrastructure has the following dependency chain:
1. **VPC** - Must be deployed first
2. **EC2** - Depends on VPC (specifically needs the public subnet)

Terragrunt automatically handles these dependencies when using `run-all` commands.

## What Gets Deployed

### Production Environment
- **VPC**: 
  - CIDR: 10.30.0.0/16
  - Public subnets: 2 (in eu-west-1a, eu-west-1b)
  - Private subnets: 1
  - NAT Gateway for private subnet internet access

- **EC2 Instance**:
  - Instance type: t2.micro
  - AMI: ami-02141377eee7defb9 (Amazon Linux 2)
  - Deployed in the first public subnet
  - EBS encryption enabled

## Useful Commands

```bash
# Plan all resources
terragrunt run-all plan

# Apply all resources
terragrunt run-all apply

# Destroy all resources
terragrunt run-all destroy

# Plan specific resource
cd aws/prod/vpc && terragrunt plan

# Apply specific resource
cd aws/prod/vpc && terragrunt apply

# Show outputs
terragrunt output

# Validate configuration
terragrunt validate
```

## Environment Management

To deploy to the test environment:
```bash
cd aws/test
terragrunt run-all plan
terragrunt run-all apply
```

The test environment uses the same modules but with different configurations as specified in `aws/test/common_vars.yaml`.

## Cleanup

To destroy all resources:
```bash
cd aws/prod  # or aws/test
terragrunt run-all destroy
```

**Note**: Always destroy resources in reverse order of dependencies if doing manually:
1. EC2 instances first
2. VPC last

## Troubleshooting

- **Authentication Issues**: Verify your AWS credentials and profile configuration
- **S3 Backend Issues**: Ensure the S3 bucket exists and you have proper permissions
- **Dependency Issues**: Use `terragrunt run-all` commands or deploy VPC before EC2
- **Region Issues**: Ensure your AWS profile region matches the region in terragrunt.hcl

## Security Notes

- Never commit AWS credentials to version control
- Use IAM roles with minimal required permissions
- Enable MFA for AWS accounts
- Regularly rotate access keys