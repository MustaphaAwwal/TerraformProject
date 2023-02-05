terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
 profile = var.AWS_PROFILE
 region = var.AWS_REGION
}
