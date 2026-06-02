#Create EC2 Instance ##########################################################################
#Create Key Pair
resource "aws_key_pair" "wordpress_key" {
  key_name       = "wordpress_key"
  public_key     = var.wordpress_key
  tags = {
    Name         = "wordpress_key"
    Project      = var.project_tag
  }
}
resource "aws_instance" "Wordpress_Instance" {
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  key_name = aws_key_pair.wordpress_key.id
  vpc_security_group_ids = [var.Instance_SG]

  user_data = templatefile("${path.module}/wordpress.sh", { rds_host = var.RDS_Address, username = var.username, password = var.password })
  tags = {
    Name = "Wordpress Instance"
    Project = var.project_tag
  }
}

resource "aws_route53_record" "mahadvo" {
  zone_id = "Z07023003N4XOL61YWO5U"
    name    = "mahadvo.com"
    type    = "A"
    records = [aws_instance.Wordpress_Instance.public_ip]
    ttl = 30
}