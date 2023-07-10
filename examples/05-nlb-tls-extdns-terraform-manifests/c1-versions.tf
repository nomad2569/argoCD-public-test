# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 4.4"
      version = ">= 4.65"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.7"
      version = ">= 2.20"
    }    
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "nety-terraform-state"
    key    = "dev/nety-cluster/terraform.tfstate"
    region = "ap-northeast-2" 
 
    # For State Locking
    # dynamodb_table = "nety-eks-cluster"
  }  
}
