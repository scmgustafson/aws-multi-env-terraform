terraform {
    backend "s3" {
    #   Also possibly different state per env based on https://docs.aws.amazon.com/prescriptive-guidance/latest/terraform-aws-provider-best-practices/backend.html
    bucket       = "terraform-demo-project-terraform-state"
    key          = "aws-multi-env-terraform/dev/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = "~> 1.12.0"
}

# Network layer for the multi-env example
module "network" {
  source = "./../modules/network"

  # Tags to be applied to all resources
  base_tags = {
    env = var.env_name
  }

  # VPC configuration
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "${var.project_name}-${var.env_name}"
  

  # Subnet configurations
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}