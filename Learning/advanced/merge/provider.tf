provider "aws" {
    access_key = "test"
    secret_key = "test"
    region = "eu-west-1"
    skip_credentials_validation = true
    skip_requesting_account_id = true
    endpoints {
      ec2 = "http://localhost:4566"
    }
  
}