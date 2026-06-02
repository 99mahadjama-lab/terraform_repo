#Creating VPC###################################################################
resource "aws_vpc" "Wordpress_VPC" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"
  tags = {
    Name           = "Wordpress VPC"
    Project        = var.project_tag
  }
}
#Creating Subnets###############################################################
#Public Subnet
resource "aws_subnet" "Public_Subnet" {
  vpc_id                  = aws_vpc.Wordpress_VPC.id
  cidr_block              = "10.0.0.128/25"
  availability_zone       = "eu-west-1c"
  map_public_ip_on_launch = true  # Assigns public IPs to instances on launch
  tags = {
    Name                  = "Public Subnet"
    Project               = var.project_tag
  }
}
#Private Subnet 1
resource "aws_subnet" "Private_Subnet_1" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "eu-west-1a"
  tags = {
    Name            = "Private Subnet 1"
    Project         = var.project_tag
  }
}
#Private Subnet 2
resource "aws_subnet" "Private_Subnet_2" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.0.64/26"
  tags = {
    Name            = "Private Subnet 2"
    Project         = var.project_tag
  }
}
#Create Internet Gateway##########################################################
resource "aws_internet_gateway" "IGW" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  tags = {
    Name            = "Internet Gateway"
    Project         = var.project_tag
  }
}
#Create Route Tables##############################################################
#Private Route Table
resource "aws_route_table" "Private_Route" {
  vpc_id            = aws_vpc.Wordpress_VPC.id
  tags = {
    Name            = "Private_Route"
    Project         = var.project_tag
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
    Project     = var.project_tag
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
    description = "Allows all traffic from dev IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
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
     Project    = var.project_tag
   }
  }

resource "aws_security_group" "RDS_SG" {
  name           = "RDS SG"
  vpc_id         = aws_vpc.Wordpress_VPC.id

  ingress {
    description = "Allows traffic from Instance"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.Instance_SG.id]
  }

  egress = []

  tags = {
     Name       = "RDS_SG"
     Project    = var.project_tag
   }
}