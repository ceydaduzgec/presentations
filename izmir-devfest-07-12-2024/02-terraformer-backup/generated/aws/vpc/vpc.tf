resource "aws_vpc" "tfer--vpc-0d24df5a71c6a274b" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "10.30.0.0/16"
  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"
  ipv6_netmask_length                  = "0"

  tags = {
    Environment = "test"
    Name        = "devfest-test-vpc"
    Namespace   = "devfest"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
  }

  tags_all = {
    Environment = "test"
    Name        = "devfest-test-vpc"
    Namespace   = "devfest"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
  }
}
