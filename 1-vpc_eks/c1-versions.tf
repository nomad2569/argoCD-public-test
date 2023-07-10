# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 4.12"
      version = ">= 4.65"
     }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "nety-terraform-state"
    key    = "dev/nety-cluster/terraform.tfstate"
    region = "ap-northeast-2" 
 
    # For State Locking
    # dynamodb_table = "nety-eks-cluster-terraform"
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}