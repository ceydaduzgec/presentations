include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  common_vars   = include.root.locals.common_vars
  name          = "ec2"
  ami           = "ami-09fc5668766215f32"
  instance_type = "t3.micro"
}

terraform {
  source = "../../..//modules/terraform-aws-ec2-instance"
}

inputs = {
  name          = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.name}"
  ami           = local.ami
  instance_type = local.instance_type
  subnet_id     = dependency.vpc.outputs.public_subnets[0]

  root_block_device = [
    {
      encrypted = true
    }
  ]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = local.common_vars.tags
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["subnet-00000000"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}
