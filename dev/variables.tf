variable project_name {
    type = string
    description = "The name identifier of this example project."
}

variable env_name {
    type = string
    description = "The name identifier of the environment all infrastructure will be deployed in"
}

variable database_username {
    sensitive = true
    type = string
    description = "The master username for the database provisioned for this project."
}

variable database_password {
    sensitive = true
    type = string
    description = "The master password for the database provisioned for this project"
}