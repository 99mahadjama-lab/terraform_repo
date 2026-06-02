module "VPC_Wordpress_Module" {
  source = "./modules/vpc"
  project_tag = local.tags.Project
  cidr_blocks = var.cidr_blocks
}

module "RDS_Wordpress_Module" {
  source = "./modules/rds"
  username = var.username
  password = var.password
  vpc_id = module.VPC_Wordpress_Module.Wordpress_Instance_VPC_ID
  private_subnet_ids = module.VPC_Wordpress_Module.Wordpress_Instance_Private_Subnet
  RDS_SG_ID = module.VPC_Wordpress_Module.Wordpress_RDS_SG_Group
}

module "EC2_Wordpress_Module" {
  source = "./modules/ec2"
  public_subnet_id = module.VPC_Wordpress_Module.Wordpress_Instance_Public_Subnet
  Instance_SG = module.VPC_Wordpress_Module.Wordpress_Instance_SG_Group
  RDS_Address = module.RDS_Wordpress_Module.Wordpress_DB_Address
  username = var.username
  password = var.password
  wordpress_key = var.public_key
}