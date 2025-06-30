variable base_tags {
    type = map(string)
    description = "The base tags to be applied to the resource allowing for a DRY module."
    default = {}
}

variable ec2_ami {
    type = string
    description = "The desired AMI of the EC2 instance."
}

variable ec2_instance_type {
    type = string
    description = "The desired instance type of the EC2 instance"
    default = "t2.micro"
}

variable ec2_subnet_id {
    type = string
    description = "The desired subnet to launch the EC2 instance in."
}

variable ec2_name {
    type = string
    description = "The name of the EC2 instance"
}

variable ec2_vpc_id {
    type = string
    description = "The VPC ID of the VPC the EC2 instance is launched in"
}

variable ec2_vpc_cidr_block {
    type = string
    description = "The VPC cidr the EC2 instance is launched in"
}

variable domain_hosted_zone_id {
    type = string
    description = "The hosted zone ID of a domain you own that the EC2 instance web page will be accessible under"
}

variable root_domain {
    type = string
    description = "The root domain of the hosted zone ID you'll use."
}

variable subdomain {
    type = string
    description = "The subdomain to be added to the root domain that the web server will be accessible at"
    default = "www"
}