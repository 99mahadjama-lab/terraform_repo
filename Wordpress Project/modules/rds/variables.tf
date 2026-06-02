variable "username" {
  type = string
}
variable "password" {
  type = string
}

variable "project_tag" {
  type = string
  default = "TF-AS1"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "RDS_SG_ID" {
  type = string
}