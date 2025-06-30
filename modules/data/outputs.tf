output rds_instance_endpoint {
    value = aws_db_instance.main.endpoint
}

output rds_database_name {
    value = aws_db_instance.main.db_name
}