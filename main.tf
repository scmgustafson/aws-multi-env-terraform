terraform {
  backend "s3" {
    #   Also possibly different state per env based on https://docs.aws.amazon.com/prescriptive-guidance/latest/terraform-aws-provider-best-practices/backend.html
    bucket = "terraform-demo-project-terraform-state"
    key    = "aws-multi-env-terraform/main"
    region = "us-west-1"
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "terraform-demo-project-terraform-state" {
  bucket = var.state_bucket_name

  tags = {
    Name = var.state_bucket_name
  }
}

resource "aws_s3_bucket_versioning" "state-versioning" {
    bucket = var.state_bucket_name
    versioning_configuration {
        status = "Enabled"
    }
}