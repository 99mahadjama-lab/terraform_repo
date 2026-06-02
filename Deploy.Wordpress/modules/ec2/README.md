# EC2 Module

## Description
This module creates the EC2 instance infrastructure for the Wordpress project, including a key pair, EC2 instance, and Route53 DNS record.

## Usage
```terraform
module "EC2_Wordpress_Module" {
  source           = "./modules/ec2"
  public_subnet_id = module.VPC_Wordpress_Module.Wordpress_Instance_Public_Subnet
  Instance_SG      = module.VPC_Wordpress_Module.Wordpress_Instance_SG_Group
  RDS_Address      = module.RDS_Wordpress_Module.Wordpress_DB_Address
  username         = var.username
  password         = var.password
  wordpress_key    = var.public_key
}
```

## Inputs
| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| wordpress_key | string | Public SSH key for EC2 access | yes | - |
| public_subnet_id | string | Public subnet ID to deploy the instance into | yes | - |
| Instance_SG | string | Security group ID for the EC2 instance | yes | - |
| RDS_Address | string | RDS endpoint address passed to WordPress config | yes | - |
| username | string | RDS master username for WordPress config | yes | - |
| password | string | RDS master password for WordPress config | yes | - |
| instance_ami | string | AMI ID for the EC2 instance | no | ami-0de864d6a3bd20ea8 |
| instance_type | string | EC2 instance type | no | t3.micro |
| project_tag | string | Project name used for tagging | no | TF-AS1 |

## Outputs
| Name | Description |
|------|-------------|
| Public_IP | The public IP address of the Wordpress instance |
| Wordpress_Instance_ID | The ID of the Wordpress EC2 instance |

## Requirements
- Terraform >= 1.0
- AWS Provider
- Region: eu-west-1
- Depends on VPC and RDS module outputs