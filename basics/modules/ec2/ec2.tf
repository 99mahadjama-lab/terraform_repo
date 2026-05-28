resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "first" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  tags = {
    Name = "tf_first_instance"
  }
}

resource "aws_instance" "second" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  tags = {
    Name = "tf_second_instance"
  }
}
