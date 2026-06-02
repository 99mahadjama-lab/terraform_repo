# VPC Module

## Description
This module creates the networking infrastructure for the Wordpress project, including a VPC, public and private subnets, internet gateway, and route tables.

## Usage
```terraform
module "vpc" {
  source      = "./modules/vpc"
  project_tag = "TF-AS1"
}
```

## Inputs
| Name | Type | Description | Required |
|------|------|-------------|----------|
| project_tag | string | The project name used for tagging resources | yes |

## Outputs
| Name | Description |
|------|-------------|
| Wordpress_Instance_VPC_ID | The ID of the VPC |
| Wordpress_Instance_Public_Subnet | The ID of the public subnet |
| Wordpress_Instance_Private_Subnet | A list of private subnet IDs |

## Requirements
- Terraform >= 1.0
- AWS Provider
- Region: eu-west-1