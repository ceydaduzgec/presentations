resource "aws_instance" "tfer--i-070cd2e18bbe9c2b3_devfest-test-devfest" {
  ami                         = "ami-02141377eee7defb9"
  associate_public_ip_address = "false"
  availability_zone           = "eu-west-1a"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  # cpu_core_count = "1"

  # cpu_options {
  #   core_count       = "1"
  #   threads_per_core = "1"
  # }

  cpu_threads_per_core = "1"

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = "false"
  disable_api_termination = "false"
  ebs_optimized           = "false"

  enclave_options {
    enabled = "false"
  }

  get_password_data                    = "false"
  hibernation                          = "false"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = "0"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = "false"
  placement_partition_number = "0"

  private_dns_name_options {
    enable_resource_name_dns_a_record    = "false"
    enable_resource_name_dns_aaaa_record = "false"
    hostname_type                        = "ip-name"
  }

  private_ip = "10.30.1.13"

  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    iops                  = "3000"

    tags = {
      Name = "devfest-test-devfest"
    }

    tags_all = {
      Name = "devfest-test-devfest"
    }

    throughput  = "125"
    volume_size = "8"
    volume_type = "gp3"
  }

  source_dest_check = "true"
  subnet_id         = "subnet-04f1abd7ee4b4c67b"

  tags = {
    Environment = "test"
    Name        = "devfest-test-devfest"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  tags_all = {
    Environment = "test"
    Name        = "devfest-test-devfest"
    Namespace   = "devfest"
    Owner       = "CeydaD"
    Terraform   = "true"
  }

  tenancy                = "default"
  vpc_security_group_ids = ["sg-0dfa1b658101ecfb7"]
}
