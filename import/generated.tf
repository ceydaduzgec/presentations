# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-00c57fa71b810de67"
resource "aws_security_group" "main" {
  description = "default VPC security group"
  egress      = []
  ingress     = []
  name        = "default"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc-default"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  vpc_id = "vpc-014738fc1473ba10f"
}

# __generated__ by Terraform
resource "aws_subnet" "private_1a" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-central-1a"
  cidr_block                                     = "10.30.11.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc-private-eu-central-1a"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  vpc_id = "vpc-014738fc1473ba10f"
}

# __generated__ by Terraform
resource "aws_subnet" "public_1b" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-central-1b"
  cidr_block                                     = "10.30.2.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc-public-eu-central-1b"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  vpc_id = "vpc-014738fc1473ba10f"
}

# __generated__ by Terraform
resource "aws_subnet" "private_1b" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-central-1b"
  cidr_block                                     = "10.30.12.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc-private-eu-central-1b"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  vpc_id = "vpc-014738fc1473ba10f"
}

# __generated__ by Terraform
resource "aws_subnet" "public_1a" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-central-1a"
  cidr_block                                     = "10.30.1.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc-public-eu-central-1a"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  vpc_id = "vpc-014738fc1473ba10f"
}

# __generated__ by Terraform
resource "aws_vpc" "main" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.30.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-vpc"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
}

# __generated__ by Terraform
resource "aws_instance" "my_ec2" {
  ami                                  = "ami-06eba3da8c195f5b5"
  associate_public_ip_address          = false
  availability_zone                    = "eu-central-1a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  ipv6_addresses                       = []
  monitoring                           = false
  private_ip                           = "10.30.1.55"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-0273f933b88bbc302"
  tags = {
    Environment = "test"
    Name        = "aws-community-day-test-ec2"
    Namespace   = "aws-community-day"
    Owner       = "CeydaDuzgec"
    Terraform   = "true"
    Terragrunt  = "true"
  }
  tenancy                = "default"
  vpc_security_group_ids = ["sg-00c57fa71b810de67"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    iops                  = 100
    kms_key_id            = "arn:aws:kms:eu-central-1:136467752943:key/99d1f45b-faeb-46ca-9102-c48654489d7f"
    tags = {
      Name = "aws-community-day-test-ec2"
    }
    throughput  = 0
    volume_size = 8
    volume_type = "gp2"
  }
}
