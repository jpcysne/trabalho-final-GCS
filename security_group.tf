resource "aws_security_group" "allow_ssh" {
  name        = "tnb_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id     = aws_vpc.VPC.id
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["179.180.138.80/32"]
  }
  tags = {
    Name = "allow_ssh"
  }
}
resource "aws_security_group" "web_egress" {
  name = "web_egress"
  description = "Permite trafego de saida para internet"
  vpc_id     = aws_vpc.VPC.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "allow_http" {
  name        = "web"
  description = "Permite trafego de entrada HTTP"
  vpc_id     = aws_vpc.VPC.id
  ingress {
    description = "Entrada HTTP de qualquer lugar"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}
resource "aws_security_group" "allow_mysql" {
  name        = "PostgreSQL"
  description = "Permite que as maquinas da web conectem no Postgre"
  vpc_id     = aws_vpc.VPC.id
  ingress {
    description = "Acesso  Postgre a partir do web"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_http.id]
  }
  tags = {
    Name = "allow_Postgre"
  }
}