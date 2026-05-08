import {
  to = aws_vpc.main
  id = "vpc-026ff70f04f649b38"
}

import {
  to = aws_subnet.public_1b
  id = "subnet-0c0038404d2941c4a"
}

import {
  to = aws_subnet.public_1a
  id = "subnet-08b12f4c2e6246859"
}

import {
  to = aws_subnet.private_1b
  id = "subnet-01492e40da8f7d2f1"
}

import {
  to = aws_subnet.private_1a
  id = "subnet-0760b0711da3d2c95"
}

import {
  to = aws_security_group.main
  id = "sg-0ce057fd6f00f9009"
}

import {
  to = aws_instance.my_ec2
  id = "i-030d33ff1aa9c8b49"
}



# terraform plan -generate-config-out="generated.tf"
