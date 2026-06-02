output "Wordpress_Instance_VPC_ID" {
  description = "VPC ID"
  value = aws_vpc.Wordpress_VPC.id
}

output "Wordpress_Instance_Public_Subnet" {
  description = "Public Subnet ID"
  value = aws_subnet.Public_Subnet.id
}

output "Wordpress_Instance_Private_Subnet" {
  description = "Private Subnet ID"
  value = [aws_subnet.Private_Subnet_1.id, aws_subnet.Private_Subnet_2.id]
}

output "Wordpress_Instance_SG_Group" {
  value = aws_security_group.Instance_SG.id
}

output "Wordpress_RDS_SG_Group" {
  value = aws_security_group.RDS_SG.id
}