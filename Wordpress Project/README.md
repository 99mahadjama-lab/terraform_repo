# Terraform WordPress Deployment

## Why I Built It
Built as part of a DevOps assignment to demonstrate infrastructure as code using Terraform modules, deploying a production-ready WordPress site on AWS.

## Stack
- **Terraform** — Infrastructure as Code
- **AWS VPC** — Networking, subnets, routing
- **AWS EC2** — WordPress application server
- **AWS RDS (MySQL)** — Managed database
- **AWS Route53** — DNS management

## What It Does
Deploys a fully functional WordPress site on AWS using a modular Terraform structure. The infrastructure includes a VPC with public and private subnets, an EC2 instance running WordPress, a MySQL RDS database in private subnets, and a Route53 DNS record pointing to the instance. The EC2 instance is automatically configured via a bash script on launch.

## Architecture
<img width="1024" height="856" alt="image" src="https://github.com/user-attachments/assets/e1f4f1e3-f9e2-402f-97a9-f627cc71fb1b" />

## How To Run It

### Prerequisites
- Terraform installed
- AWS credentials configured
- An existing Route53 hosted zone
- An SSH key pair

### Steps
```bash
# Clone the repo
git clone <your-repo-url>
cd wordpress-terraform

# Initialise Terraform
terraform init

# Review the plan
terraform plan

# Deploy
terraform apply
```

### Required Variables
| Name | Description |
|------|-------------|
| public_key | Your SSH public key |
| username | RDS master username |
| password | RDS master password |
| cidr_blocks | Your IP for SSH access |
