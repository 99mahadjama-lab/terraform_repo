
locals {
  tags = {
    Project = "TF-AS1"
  }
}

locals {
  instance_ami = "ami-0de864d6a3bd20ea8"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "public_key" {
    type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}
