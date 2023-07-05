terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " = 4.31.0"
    }
  }
  backend "s3" {
    bucket         = "gasida-ung-t101study-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}
provider "aws" {
  region = var.region
}