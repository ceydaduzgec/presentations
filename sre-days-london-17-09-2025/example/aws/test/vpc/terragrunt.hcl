include {
  path = find_in_parent_folders()
}

locals {
  common_vars            = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  name                   = "vpc"
  cidr                   = "10.30.0.0/16"
  azs                    = ["eu-west-1a", "eu-west-1b"]
  public_subnets         = ["10.30.1.0/24", "10.30.2.0/24"]
  private_subnets        = ["10.30.11.0/24"]
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  single_nat_gateway     = true
}

terraform {
  source = "../../..//modules/terraform-aws-vpc"
}

inputs = {
  name = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.name}"
  azs  = local.azs
  cidr = local.cidr

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets

  # enable_nat_gateway     = local.enable_nat_gateway
  # single_nat_gateway     = local.single_nat_gateway
  # one_nat_gateway_per_az = local.one_nat_gateway_per_az
  # enable_dns_hostnames   = local.enable_dns_hostnames

  tags = local.common_vars.tags
}
