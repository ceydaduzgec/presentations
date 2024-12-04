include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  name        = "vpn-ec2-sg"
}

terraform {
  source = ".../../../../../..//modules/terraform-aws-security-group"
}

inputs = {
  name        = "${local.common_vars.namespace}-${local.common_vars.environment}-${local.name}"
  description = "Security group for VPN ec2 instance"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      description = "UDP access from anywhere"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound connections"
    }
  ]

  tags = local.common_vars.tags
}

dependency "vpc" {
  config_path = "../../vpc"
}

