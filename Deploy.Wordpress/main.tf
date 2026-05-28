#Creating VPC###################################################################
resource "aws_vpc" "Wordpress_VPC" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"
  tags = {
    Name           = "Wordpress VPC"
    Project        = local.tags.Project
  }
}
#Creating Subnets###############################################################
#Public Subnet
resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.Wordpress_VPC.id
  cidr_block              = "10.0.0.128/25"
  availability_zone       = "eu-west-2c"
  map_public_ip_on_launch = true  # Assigns public IPs to instances on launch
  tags = {
    Name                  = "Public Subnet"
    Project               = local.tags.Project
  }
}
#Private Subnet 1
resource "aws_subnet" "Private_Subnet_1" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "eu-west-2a"
  tags = {
    Name            = "Private Subnet 1"
    Project         = local.tags.Project
  }
}
#Private Subnet 2
resource "aws_subnet" "Private_Subnet_2" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  availability_zone = "eu-west-2b"
  cidr_block        = "10.0.0.64/26"
  tags = {
    Name            = "Private Subnet 2"
    Project         = local.tags.Project
  }
}
#Create Internet Gateway##########################################################
resource "aws_internet_gateway" "IGW" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  tags = {
    Name            = "Internet Gateway"
    Project         = local.tags.Project
  }
}
#Create Route Tables##############################################################
#Private Route Table
resource "aws_route_table" "Private_Route" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  tags = {
    Name            = "Private_Route"
    Project         = local.tags.Project
  }
}
#Public Route Table
resource "aws_route_table" "Public_Route" {
  vpc_id        = aws_vpc.Wordpress_VPC.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.IGW.id
  }
  tags = {
    Name        = "Public_Route"
    Project     = local.tags.Project
  }
}
#Route Table Association############################################################
#Public Route
resource "aws_route_table_association" "Public_AS" {
  subnet_id      = aws_subnet.Public_Subnet.id
  route_table_id = aws_route_table.Public_Route.id
}
#Private Route
resource "aws_route_table_association" "Private_AS1" {
  subnet_id      = aws_subnet.Private_Subnet_1.id
  route_table_id = aws_route_table.Private_Route.id
}
resource "aws_route_table_association" "Private_AS2" {
  subnet_id      = aws_subnet.Private_Subnet_2.id
  route_table_id = aws_route_table.Private_Route.id
}
#Creating Instance###################################################################
#Create Key Pair
resource "aws_key_pair" "SSH_Key" {
  key_name       = "SSH_Key"
  public_key     = var.public_key
  tags = {
    Name         = "SSH_Key"
    Project      = local.tags.Project
  }
}
#Creating Security Groups############################################################
#Instance SG
resource "aws_security_group" "Instance_SG" {
  name           = "Instance SG"
  vpc_id         = aws_vpc.Wordpress_VPC.id

  ingress {
    description ="Allows traffic from HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  ingress {
    description = "Allows traffic from HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
   
   ingress {
    description = "Allows traffic from SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "143.58.163.0/32","193.221.133.170/32" ]
   }

   egress {
    description = "Allows out all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
   }

   tags = {
     Name       = "Instance_SG"
     Project    = local.tags.Project
   }
  }


#Create EC2 Instance
resource "aws_instance" "Wordpress_Instance" {
  ami = local.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.Public_Subnet.id
  key_name = aws_key_pair.SSH_Key.key_name
  vpc_security_group_ids = [aws_security_group.Instance_SG.id]

  user_data = file("${path.module}/wordpress.sh")
  tags = {
    Name = "Wordpress Instance"
    Project = local.tags.Project
  }
}

