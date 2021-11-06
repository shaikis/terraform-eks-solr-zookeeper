provider "aws" {
    region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "ismail-tio-test"
    key    = "vpc/eks/terraform.tfstate"
    region = "eu-west-1"
  }
}