output "Wordpress_Instance_VPC_ID" {
  description = "VPC ID"
  value = module.VPC_Wordpress_Module.Wordpress_Instance_VPC_ID
}
output "Wordpress_Instance_ID" {
  description = "Wordpress Instance ID"
  value = module.EC2_Wordpress_Module.Wordpress_Instance_ID
}
output "Wordpress_Instance_IP" {
  description = "public ip of wordpress instance"
  value = module.EC2_Wordpress_Module.Public_IP
}
output "Wordpress_Instance_RDS_Endpoint" {
  description = "DB Address"
  value = module.RDS_Wordpress_Module.Wordpress_DB_Address
}
output "Wordpress_Instance_Security_Group_IDs" {
  description = "Instance security ID"
  value = module.VPC_Wordpress_Module.Wordpress_Instance_SG_Group
}
output "Wordpress_RDS_Security_Group_IDs" {
  description = "RDS security group ID"
  value = module.VPC_Wordpress_Module.Wordpress_RDS_SG_Group
}