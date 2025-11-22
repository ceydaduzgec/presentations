module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "devfest-test-vpc"
  cidr = "10.30.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
  public_subnets  = ["10.30.101.0/24", "10.30.102.0/24", "10.30.103.0/24"]

  # Matching original resource configurations
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"

  # Networking options
  enable_nat_gateway = true
  single_nat_gateway = true

  # Tags matching the original resource
  tags = {
    Environment = "test"
    Name        = "devfest-test-vpc"
    Namespace   = "devfest"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
  }
}
