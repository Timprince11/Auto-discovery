
# Create multi AZ RDS database

# DB subnet group = "aws_subnet" "PADUS_RDS_subnet_groups"
resource "aws_db_subnet_group" "PADUS1_RDS_subnet_groups" {
  name       = var.db_name
  subnet_ids = var.subnet_id
  tags = {
    Name = var.rds_name
  }
}

# create RDS Mysql Database
resource "aws_db_instance" "PADUS1db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  port                   = var.mysql_port
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_passwd
  identifier             = var.identifier
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.PADUS1_RDS_subnet_groups.name
  vpc_security_group_ids = [var.rds_sg]
  publicly_accessible    = false
  multi_az               = true
}
