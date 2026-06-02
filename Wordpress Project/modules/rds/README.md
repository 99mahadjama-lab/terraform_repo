# RDS Module

## Description
This module creates the RDS MySQL database infrastructure for the Wordpress project, including a subnet group and RDS instance.

## Usage
```terraform
module "RDS_Wordpress_Module" {
  source             = "./modules/rds"
  username           = var.username
  password           = var.password
  vpc_id             = module.VPC_Wordpress_Module.Wordpress_Instance_VPC_ID
  private_subnet_ids = module.VPC_Wordpress_Module.Wordpress_Instance_Private_Subnet
  project_tag        = "TF-AS1"
}
```

## Inputs
| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| username | string | RDS master username | yes | - |
| password | string | RDS master password | yes | - |
| vpc_id | string | VPC ID to deploy RDS into | yes | - |
| private_subnet_ids | list(string) | List of private subnet IDs for the RDS subnet group | yes | - |
| RDS_SG_ID | string | Security group ID for the RDS instance | yes | - |
| project_tag | string | Project name used for tagging | no | TF-AS1 |

## Outputs
| Name | Description |
|------|-------------|
| Wordpress_DB_Address | The endpoint address of the RDS instance |

## Requirements
- Terraform >= 1.0
- AWS Provider
- Depends on VPC module outputs