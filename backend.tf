terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = var.bucket
    key    = var.key
    region = "eu-west-1"
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}