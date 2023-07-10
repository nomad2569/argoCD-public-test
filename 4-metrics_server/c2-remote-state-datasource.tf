# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "nety-terraform-state"
    key    = "dev/nety-cluster/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

