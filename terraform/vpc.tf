resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}