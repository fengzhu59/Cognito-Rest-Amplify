resource "aws_db_instance" "default" {
  db_name             = "freetier"
  identifier          = "free-tier-db"
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  username            = var.username
  password            = var.password
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    purpose = "testing"
  }
}
