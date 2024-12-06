resource "aws_subnet" "tfer--subnet-04f1abd7ee4b4c67b" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.30.1.0/24"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Environment = "test"
    Name        = "devfest-test-vpc-public-eu-west-1a"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  tags_all = {
    Environment = "test"
    Name        = "devfest-test-vpc-public-eu-west-1a"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  vpc_id = "${data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0d24df5a71c6a274b_id}"
}

resource "aws_subnet" "tfer--subnet-0520c3cdcbabb9216" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.30.11.0/24"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Environment = "test"
    Name        = "devfest-test-vpc-private-eu-west-1a"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  tags_all = {
    Environment = "test"
    Name        = "devfest-test-vpc-private-eu-west-1a"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  vpc_id = "${data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0d24df5a71c6a274b_id}"
}

resource "aws_subnet" "tfer--subnet-0ab4481dd28121647" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.30.2.0/24"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Environment = "test"
    Name        = "devfest-test-vpc-public-eu-west-1b"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  tags_all = {
    Environment = "test"
    Name        = "devfest-test-vpc-public-eu-west-1b"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  vpc_id = "${data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0d24df5a71c6a274b_id}"
}
