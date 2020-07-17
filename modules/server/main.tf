resource "aws_instance" "server" {
    ami           = var.ami
    instance_type = var.tipo_instancia
    key_name = var.chave_ssh
    vpc_security_group_ids = concat([aws_security_group.allow_ssh.id, aws_security_group.web_egress.id], var.security_groups_ids)
    tags = var.tags
    user_data = var.user_data
}

resource "aws_security_group" "allow_ssh" {
  name_prefix        = "sg_aula_ssh"
  description = "Allow ssh inbound traffic"
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.200.85.109/32"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "web_egress" {
  name_prefix = "sg_aula_web_egress"
  description = "Permite trafego de saida para internet"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}