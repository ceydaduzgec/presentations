# Terragrunt AWS Infrastructure

This repository demonstrates how to use Terragrunt to manage AWS infrastructure across multiple environments (prod/test) with reusable Terraform modules.

## Project Structure

```
.
├── environments/
│   ├── global_vars.yaml             # Shared variables (namespace, region, common tags)
│   ├── prod/                        # Production environment
│   │   ├── common_vars.yaml         # Prod-specific variables (CIDRs, env name, env tag)
│   │   ├── root.hcl                 # Provider + remote state configuration
│   │   ├── ec2/
│   │   │   └── terragrunt.hcl
│   │   └── vpc/
│   │       └── terragrunt.hcl
│   └── test/                        # Test environment (same structure)
│       ├── common_vars.yaml
│       ├── root.hcl
│       ├── ec2/
│       │   ├── import.tf            # Example: import block (Terraform v1.5+)
│       │   └── terragrunt.hcl
│       └── vpc/
│           └── terragrunt.hcl
└── modules/                         # Reusable Terraform modules
    ├── terraform-aws-ec2-instance/
    └── terraform-aws-vpc/
```

### Variable Inheritance

Variables are split into two levels to avoid duplication:

| File                                   | Scope            | Contains                                       |
|----------------------------------------|------------------|------------------------------------------------|
| `environments/global_vars.yaml`        | All environments | `namespace`, `region`, shared `tags`           |
| `environments/<env>/common_vars.yaml`  | Per environment  | `environment`, `vpc` CIDRs/AZs, env `tags`     |

`root.hcl` merges both files into a single `common_vars` local, which child modules access via `include.root.locals.common_vars`.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.10
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) >= 1.0
- AWS CLI configured with a named profile

```bash
# macOS
brew install terraform terragrunt
```

## Getting Started

### 1. Configure AWS credentials

```bash
aws configure --profile your-profile-name
```

Update the profile name in both `root.hcl` files:

```hcl
# environments/prod/root.hcl  and  environments/test/root.hcl
generate "provider" {
  contents = <<EOF
provider "aws" {
  region  = "${local.common_vars.region}"
  profile = "your-profile-name"   # <-- change this
}
EOF
}

remote_state {
  config = {
    profile = "your-profile-name"  # <-- change this
    # ...
  }
}
```

Alternatively, use environment variables and remove `profile`:

```bash
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_DEFAULT_REGION="eu-central-1"
```

### 2. Customize variables

Edit `environments/global_vars.yaml` for shared values:

```yaml
namespace: your-project-name   # <-- change this
region: eu-central-1

tags:
  Namespace: your-project-name  # <-- change this
  Owner: YourName               # <-- change this
  Terraform: true
  Terragrunt: true
```

Edit `environments/<env>/common_vars.yaml` for environment-specific values:

```yaml
environment: prod   # or test

vpc:
  cidr: "10.40.0.0/16"
  # ...

tags:
  Environment: prod
```

### 3. Bootstrap the backend (first time only)

Terragrunt 1.0 separates backend infrastructure creation from `apply`. Run this once per environment before the first `apply`:

```bash
cd environments/prod/vpc
terragrunt backend bootstrap
```

This creates the S3 bucket (`<namespace>-<environment>-terragrunt-state`) used for remote state.

### 4. Deploy

Deploy resources in dependency order — VPC must come before EC2:

```bash
# Production
cd environments/prod/vpc && terragrunt apply
cd environments/prod/ec2 && terragrunt apply

# Test
cd environments/test/vpc && terragrunt apply
cd environments/test/ec2 && terragrunt apply
```

Or deploy an entire environment at once:

```bash
cd environments/prod
terragrunt run-all apply
```

## Key Features

### S3 Native State Locking (Terraform 1.10+)

State locking uses S3's native lockfile feature instead of DynamoDB — no extra resources required:

```hcl
remote_state {
  backend = "s3"
  config = {
    use_lockfile = true   # S3 native locking, no DynamoDB needed
    encrypt      = true
    # ...
  }
}
```

### Import Block (Terraform 1.5+)

`environments/test/ec2/import.tf` demonstrates how to bring an existing EC2 instance under Terraform management:

```hcl
import {
  to = aws_instance.this[0]
  id = "i-0123456789abcdef0"
}
```

Generate the resource configuration automatically:

```bash
cd environments/test/ec2
terragrunt plan -generate-config-out=generated.tf
```

### IMDSv2 Enforcement

All EC2 instances require IMDSv2 (token-based metadata access):

```hcl
metadata_options = {
  http_endpoint               = "enabled"
  http_tokens                 = "required"
  http_put_response_hop_limit = 1
}
```

## What Gets Deployed

| Resource          | Test                  | Prod                  |
|-------------------|-----------------------|-----------------------|
| VPC CIDR          | 10.30.0.0/16          | 10.40.0.0/16          |
| Public subnets    | 2 (eu-central-1a/b)   | 2 (eu-central-1a/b)   |
| Private subnets   | 1                     | 1                     |
| NAT Gateway       | None (cost = $0)      | None (cost = $0)      |
| EC2 instance type | t3.micro              | t3.micro              |
| EBS encryption    | Yes                   | Yes                   |

## Useful Commands

```bash
# Bootstrap backend (first time only, per environment)
terragrunt backend bootstrap

# Plan / apply / destroy a single resource
terragrunt plan
terragrunt apply
terragrunt destroy

# Plan / apply / destroy all resources in an environment
cd environments/prod
terragrunt run-all plan
terragrunt run-all apply
terragrunt run-all destroy

# Show outputs
terragrunt output

# Validate configuration
terragrunt validate
```

## Cleanup

Destroy resources in reverse dependency order:

```bash
cd environments/prod/ec2 && terragrunt destroy
cd environments/prod/vpc && terragrunt destroy
```

Or destroy everything at once:

```bash
cd environments/prod
terragrunt run-all destroy
```

## Troubleshooting

| Problem                          | Solution                                                              |
|----------------------------------|-----------------------------------------------------------------------|
| S3 bucket does not exist         | Run `terragrunt backend bootstrap` first                              |
| `backend block` error in module  | Add `backend "s3" {}` to the module's `versions.tf`                  |
| Authentication errors            | Check profile name in `root.hcl` and `~/.aws/credentials`            |
| Region mismatch                  | Ensure AZs in `common_vars.yaml` match the region in `global_vars.yaml` |

## Security Notes

- Never commit AWS credentials to version control
- Use IAM roles with minimal required permissions
- EBS volumes are encrypted by default
- IMDSv2 is enforced on all EC2 instances
