#RDS Setup #####################################################################################
#Create RDS Subnet group
resource "aws_db_subnet_group" "RDS_Subnet_Group" {
  name       = "rds_subnet_group"
  subnet_ids = var.private_subnet_ids


  tags = {
    Name = "RDS_Subnet_Group"
    Project = var.project_tag
  }
}
#Create RDS
resource "aws_db_instance" "wordpress" {
  allocated_storage    = 10
  db_name              = "wordpress_db"
  engine               = "mysql"
  engine_version       = "8.4.8"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.4"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.RDS_Subnet_Group.id
  vpc_security_group_ids = [var.RDS_SG_ID]

  tags = {
    Name = "Wordpress DB"
    Project = var.project_tag
  }
}