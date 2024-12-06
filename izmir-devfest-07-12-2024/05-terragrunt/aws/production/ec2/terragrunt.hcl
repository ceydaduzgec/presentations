include {
  path = find_in_parent_folders()
}

locals {
  common_vars            = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  name                   = "devfest"
  ami                    = "ami-02141377eee7defb9"
  instance_type          = "t2.micro"
  encrypted              = true
}

terraform {
  source = "../../..//modules/terraform-aws-ec2-instance"
}

inputs = {
  name                   = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.name}"
  ami                    = local.ami
  instance_type          = local.instance_type
  subnet_id              = dependency.vpc.outputs.public_subnets[0]

  tags = local.common_vars.tags
}

dependency "vpc" {
  config_path = "../vpc"
}
