variable "num_instances" {
  type = number
  default = 3
}

locals {
  indices = range(0, var.num_instances)
}

resource "aws_instance" "range_example" {
  for_each = {
    for i in local.indices : i => i
  }
  ami = "ami-test"
  instance_type = "t3.micro"
  tags = {
    Name = "range-instance-${each.key}"
  }
}