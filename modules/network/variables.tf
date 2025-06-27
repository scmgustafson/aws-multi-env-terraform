variable base_tags {
    type = map(string)
    description = "The base tags to be applied to the resource allowing for a DRY module."
    default = {}
}

variable vpc_name {
    type = string
    description = "The name of the VPC"
    default = ""
}

variable vpc_cidr {
    type = string
    description = "The value of the cidr_block argument for the vpc. Ex: 10.0.0.0/16"
}

variable public_subnet_cidr {
    type = string
    description = "The value of the cidr_block argument for the Subnet. Ex: 10.0.1.0/24"
}

variable private_subnet_cidr {
    type = string
    description = "The value of the cidr_block argument for the Subnet. Ex: 10.0.1.0/24"
}
