# DB subnet group
resource "aws_db_subnet_group" "private" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.rds_subnet_id

  tags = merge(var.base_tags, 
    {
      Name = "${var.rds_subnet_group_name}"
    }
  )
}

# RDS instance in a private subnet
resource "aws_db_instance" "main" {
  allocated_storage    = var.rds_allocated_storage
  storage_type = var.rds_storage_type
  db_name              = "${var.rds_instance_name}db"
  engine               = var.rds_engine_type
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_type
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.private.name
}