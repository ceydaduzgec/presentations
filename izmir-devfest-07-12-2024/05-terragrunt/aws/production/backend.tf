# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "devfest-test-terragrunt-state"
    encrypt = true
    key     = "./terraform.tfstate"
    profile = "sufledev"
    region  = "eu-west-1"
  }
}
