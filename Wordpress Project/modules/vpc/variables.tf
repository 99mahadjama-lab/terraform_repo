variable "project_tag" {
  type = string
  default = "TF-AS1"
}
variable "cidr_blocks" {
  type = list(string)
}