# variable "user_defined_name" {
#     type = string
#     default = ""  
# }

# resource "aws_instance" "My_Instance" {
#     ami = "ami-test"
#     instance_type = "t3.micro"
#     tags = {
#         Name = coalesce(var.user_defined_name, "Generic-Name")
#         }
# }

##################################################################################################
##################################################################################################
##################################################################################################

# data "external" "my_data" {
#   program = ["python3", "${path.module}/script.py"]
#   query = {
#     Name = "some_api"
#   }
# }

# resource "aws_instance" "my_resource" {
#     ami = "ami-test"
#     instance_type = "t3.micro"
#     tags = {
#         Name = coalesce(lookup(data.external.my_data.result, "id", "fallback-name"), "fallback-name")
#         Description = coalesce(lookup(data.external.my_data.result, "description", "No description available"), "No description available")
# }
# }

##################################################################################################
##################################################################################################
##################################################################################################

variable "environment_settings" {
  type = map(string)
  default = {
  }
}

locals {
  config_file_value = try(
    jsondecode(file("${path.module}/config.json")).my_setting,
    null
  )

  environment_value = lookup(var.environment_settings, "my_setting", null)
}

resource "null_resource" "example_config" {
  triggers = {
    setting_in_use = coalesce(
        local.config_file_value,
        local.environment_value,
        "default_value"
    )
  }
}