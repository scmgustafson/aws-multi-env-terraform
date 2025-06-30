variable base_tags {
    type = map(string)
    description = "The base tags to be applied to the resource allowing for a DRY module."
    default = {}
}

variable rds_subnet_group_name {
    type = string
    description = "The name of the RDS subnet group to be created."
    default = "private-rds-subnet-group"
}

variable rds_subnet_id {
    type = list(string)
    description = "The IDs of the subnets that the DB subnet group should utilize."
}

variable rds_allocated_storage {
    type = number
    description = "The value in Gb of the allocated storage for the RDS instance. Ex: 20 (default for free tier)"
    default = 20
}

variable rds_storage_type {
    type = string
    description = "The storage class to be used for the RDS instance. Ex: gp2 (default for free tier)"
    default = "gp2"
}

variable rds_instance_name {
    type = string
    description = "The name of the RDS instance."
}

variable rds_database_name {
    type = string
    description = "The name of the logical DB created on the RDS instance."
}

variable rds_engine_type {
    type = string
    description = "The underlying DB engine type of the RDS instance. Ex: mysql"
    default = "mysql"
}

variable rds_engine_version {
    type = string
    description = "The version number desired for the engine type. Ex: 8.0"
    default = "8.0"
}

variable rds_instance_type {
    type = string
    description = "The instance type of the RDS instance. Ex: db.t3.micro (for free tier)"
    default = "db.t3.micro"
}

variable rds_parameter_group_name {
    type = string
    description = "The name of the parameter group to be applied to the RDS instance."
    default = "default.mysql8.0"
}

variable rds_username {
    sensitive = true
    type = string
    description = "The master username for the RDS instance"
}

variable rds_password {
    sensitive = true
    type = string
    description = "The master password for the RDS instance"
}