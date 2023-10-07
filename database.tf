resource "aws_db_instance" "hrapp" {
  allocated_storage        = 10
  identifier               = "hrapp-main"
  db_subnet_group_name     = aws_db_subnet_group.hrapp_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.hrapp_db_sg.id]
  db_name                  = "hrapp"
  engine                   = "postgres"
  instance_class           = "db.t3.micro"
  username                 = var.db_username
  password                 = var.db_password
  skip_final_snapshot      = true
  publicly_accessible      = true
  delete_automated_backups = true
  availability_zone        = var.availability_zone_c
  apply_immediately        = true
}
