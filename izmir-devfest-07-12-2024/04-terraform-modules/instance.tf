module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.5.0"  # Use the latest version

  name = "devfest-test-devfest"

  # Instance configuration
  ami                             = "ami-02141377eee7defb9"
  instance_type                   = "t2.micro"
  availability_zone               = "eu-west-1a"
  subnet_id                       = module.vpc.private_subnets[0]
  vpc_security_group_ids          = ["sg-0dfa1b658101ecfb7"]
  associate_public_ip_address     = false
  

  # Advanced instance configurations
  cpu_threads_per_core            = 1
  disable_api_stop                = false
  disable_api_termination         = false
  ebs_optimized                   = false
  get_password_data               = false
  hibernation                     = false
  instance_initiated_shutdown_behavior = "stop"
  monitoring                      = false
  source_dest_check               = true
  tenancy                         = "default"

  # Metadata options
  metadata_options = {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  # Capacity and CPU options
  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  # Maintenance options
  maintenance_options = {
    auto_recovery = "default"
  }

  # Tags
  tags = {
    Environment = "test"
    Name        = "devfest-test-devfest"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }
}