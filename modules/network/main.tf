# Network Module

# VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  # Tag pattern that will be followed for all resources to keep variables.tf DRYer
  tags = merge(var.base_tags, 
    {
        Name = "${var.vpc_name}-vpc"
    }
  )
}

# Subnets
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr

  tags = merge(var.base_tags, 
    {
        Name = "${var.vpc_name}-public-subnet"
    }
  )
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr

  tags = merge(var.base_tags, 
    {
        Name = "${var.vpc_name}-private-subnet"
    }
  )
}

# nacl

# Gateway and EIPs
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.base_tags, 
    {
        Name = "${var.vpc_name}-igw"
    }
  )
}

resource "aws_eip" "nat_gw_eip" {
  domain   = "vpc"

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.allocation_id
  subnet_id     = aws_subnet.public.id

  tags = merge(var.base_tags, 
    {
        Name = "${var.vpc_name}-nat-gw"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# Route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}