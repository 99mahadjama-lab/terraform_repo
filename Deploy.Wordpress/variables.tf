
locals {
  tags = {
    Project = "TF-AS1"
  }
}

locals {
  instance_ami = "ami-0d114020bf27f27cf"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "public_key" {
    type = string
}
