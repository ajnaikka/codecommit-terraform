# Setting provider and region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
# This is used to store the terraform state file in S3 bucket
backend "s3" {
  bucket = "cc-terraform-state"
  key    = "iam/terraform.tfstate"
  region = "ap-south-1"
# This is used to lock the state file when someone is working on it
  dynamodb_table = "iam-terraform-lock"
  encrypt        = true
  } 
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

