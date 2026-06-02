variable "userdata_file" {
  type = string
  default = "user_data.sh"
}

resource "aws_instance" "file_example" {
  ami = "ami-test"
  instance_type = "t3.micro"
  user_data = file(var.userdata_file)
  tags = {
    Name = "file-example-instance"
  }
}