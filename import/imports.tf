import {
  to = aws_vpc.main
  id = "vpc-014738fc1473ba10f"
}

import {
  to = aws_subnet.public_1b
  id = "subnet-08066da35fb3a756f"
}

import {
  to = aws_subnet.public_1a
  id = "subnet-0273f933b88bbc302"
}

import {
  to = aws_subnet.private_1b
  id = "subnet-06d8ecd64726a5f0f"
}

import {
  to = aws_subnet.private_1a
  id = "subnet-09f52b882211ec415"
}

import {
  to = aws_security_group.main
  id = "sg-00c57fa71b810de67"
}

import {
  to = aws_instance.my_ec2
  id = "i-045d09d9cb1d65234"
}



# terraform plan -generate-config-out="generated.tf"