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
  private2_subnet_cidr = "10.0.3.0/24"
}

module "web" {
    source = "../modules/web"

    base_tags = {
        env = var.env_name
    }

    # Web Server configuration
    ec2_name = "${module.network.vpc_id}-web-server"
    # Hardcoded latest Amazon Linux 2 AMI
    ec2_ami = "ami-061ad72bc140532fd"
    # Configure network information with output from `network` module
    ec2_subnet_id = module.network.public_subnet_id
    ec2_vpc_id = module.network.vpc_id
    ec2_vpc_cidr_block = module.network.vpc_cidr_block

    # DNS Record
    # Using an existing domain I already own
    domain_hosted_zone_id = "Z04600212LU1F0XIW9IB8"
}

module "data" {
    source = "../modules/data"

    base_tags = {
        env = var.env_name
    }

    # Subnet Group (utilizes the previously created private subnet from the network module)
    rds_subnet_group_name = "${module.network.vpc_id}-private-subnet-group"
    rds_subnet_id = [module.network.private_subnet_id, module.network.private2_subnet_id]

    # RDS Instance (defaults to free-tier MySQL)
    rds_instance_name = "example"
    rds_username = var.database_username
    rds_password = var.database_password
}