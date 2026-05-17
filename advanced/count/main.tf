resource "aws_instance" "test" {
  count = 3
  ami = "ami-test"
  instance_type = "t3.micro"
  tags = {
    Name = "test-instance-${count.index}"
  }
} 
