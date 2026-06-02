variable "instance_type" {
    type = string
    default = "t3.micro"
}

locals {
    instance_ami = "ami-0d114020bf27f27cf"
}

output "instance_id" {
  description = "The ID of the first EC2 instance"
  value = aws_instance.first.id
}
output "instance2_id" {
  description = "The ID of the second EC2 instance"
  value = aws_instance.second.id
}