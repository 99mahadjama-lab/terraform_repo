variable "project_tag" {
  type = string
  default = "TF-AS1"
}
variable "instance_ami" {
  type = string
  default= "ami-0de864d6a3bd20ea8"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}
variable "public_subnet_id" {
  type = string
}
variable "Instance_SG" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "RDS_Address" {
  type = string
}
variable "wordpress_key" {
  type = string
  sensitive = true
}