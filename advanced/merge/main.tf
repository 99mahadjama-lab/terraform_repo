variable "environment" {
  type = string
  default = "dev"
}

locals {
    default_tags = {
        CreatedBy = "Terraform"
        Department = "Engineering"
    }
}

variable "env_tags" {
    type = map(string)
    default = {
      "Env" = "dev"
      "Tier" = "sandbox"
    } 
}

resource "aws_instance" "merged_tags_example" {
    ami = "test-ami"
    instance_type = "t3.micro"

    tags = merge(
        local.default_tags,
        var.env_tags,
        {
            Name = "merged-tags-${var.environment}"
        }
    )
}

