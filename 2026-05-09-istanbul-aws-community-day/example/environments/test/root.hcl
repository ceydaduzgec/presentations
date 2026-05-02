locals {
  global_vars = yamldecode(file(find_in_parent_folders("global_vars.yaml")))
  env_vars    = yamldecode(file(find_in_parent_folders("common_vars.yaml")))

  common_vars = {
    namespace   = local.global_vars.namespace
    region      = local.global_vars.region
    environment = local.env_vars.environment
    vpc         = local.env_vars.vpc
    tags        = merge(local.global_vars.tags, local.env_vars.tags)
  }
}

terraform_version_constraint  = ">= 1.10"
terragrunt_version_constraint = ">= 0.67.0"

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.common_vars.region}"
  profile = "digitalops" # Use your AWS profile name here
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket       = "${local.common_vars.namespace}-${local.common_vars.environment}-terragrunt-state"
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = local.common_vars.region
    encrypt      = true
    use_lockfile = true
    profile      = "digitalops"
  }
}
