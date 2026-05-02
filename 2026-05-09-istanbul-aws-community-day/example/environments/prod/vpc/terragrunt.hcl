include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  common_vars = include.root.locals.common_vars
  name        = "vpc"
}

terraform {
  source = "../../..//modules/terraform-aws-vpc"
}

inputs = {
  name = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.name}"
  cidr = local.common_vars.vpc.cidr
  azs  = local.common_vars.vpc.azs

  public_subnets  = local.common_vars.vpc.public_subnets
  private_subnets = local.common_vars.vpc.private_subnets

  enable_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.common_vars.tags
}
