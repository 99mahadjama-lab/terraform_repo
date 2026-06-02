# variable "environment" {
#     type = string
#     default = "dev" 
# }

# resource "aws_instance" "conditional_instance" {
#     ami = "ami-test"
    
#     #If the environment is prod then instance type is t3.large, else t3.micro
#     instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"

#     tags = {
#         Name = "conditional-instance-${var.environment}"
#     } 
# }

##################################################################################################
##################################################################################################
##################################################################################################

# variable "environment" {
#     type = string
#     default = "dev" 
# }

# resource "aws_instance" "main" {
#     ami = "ami-test"
#     instance_type = "t3.micro"
#     tags = {
#       Name = "main-instance"
#     }
# }

# resource "aws_eip" "optional_eip" {
#     count = var.environment == "prod" ? 1 : 0
#     instance = aws_instance.main.id
#     tags = {
#       Name = "conditional-eip"
#     }
# }

##################################################################################################
##################################################################################################
##################################################################################################

# variable "is_high_priority" {
#     type = bool
#     default = false
# }

# locals {
#   selected_type = var.is_high_priority ? "t3.large" : "t3.micro"
#   #if its a high priority add a special tag
#   extra_tags = var.is_high_priority ? { Priority = "High"} : {}
# }

# resource "aws_instance" "local_condition" {
#     ami = "ami-test"
#     instance_type = local.selected_type
#     tags = merge(
#         {
#             Name = "local-conditional"
#         },
#         local.extra_tags
#     )
# }

##################################################################################################
##################################################################################################
##################################################################################################

# variable "enable_ssh" {
#   type = bool
#   default = false
# }

# resource "aws_security_group" "dynamic_rules" {
#   name = "conditional-sg"
#   description = "Example SG with option SSH"

#   vpc_id = "VPC-123456" #Local Stack ignores this but we must define something

# #Always create a HTTP rule
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# # Conditionally create an SSH rule

# dynamic "ingress" {
#       for_each = var.enable_ssh ? [1] : []
#     content {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   }
# }

##################################################################################################
##################################################################################################
##################################################################################################

variable "environment" {
    type = string
    default = "dev" 
}

variable "is_high_priority" {
  type = bool
  default = false
}

resource "aws_instance" "combo_instance" {
    count = var.environment == "prod" ? (var.is_high_priority ? 3 : 2) : 1
    ami = "ami-test"
    instance_type = var.is_high_priority ? "t3.large" : "t3.micro"
    tags = {
        name = "combo-instance-${count.index}"
        Environment = var.environment
        Priority = var.is_high_priority ? "High" : "Normal"
    }
}