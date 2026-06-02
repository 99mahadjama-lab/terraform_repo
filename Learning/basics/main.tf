module "ec2" {
  source = "./modules/ec2"
}

output "instance2_id" {
  value = module.ec2
}