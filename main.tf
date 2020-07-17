provider "aws" {
  profile    = "aula-terraform"
  region = "us-east-1"
}

module "web" {
  source = "./modules/server"
  ami = var.ami["us-east-1"]
  security_groups_ids = [aws_security_group.allow_http.id]
  user_data = templatefile("scripts/prepara_web.sh.tpl", { db_instance_ip = module.db.ip_privado })
  tags = {
    Name = "web"
  }
}

module "db" {
  source = "./modules/server"
  ami = var.ami["us-east-1"]
  security_groups_ids = [aws_security_group.allow_mysql.id]
  user_data = file("scripts/prepara_bd.sh")
  tags = {
    Name = "db"
  }
}
module "s3" {
  source = "./modules/s3_bucket"
  bucket_name = "ansible-config-jprubiogcs"
  upload_file = {
    src = "ansible/provisioning.zip",
    dest = "ansible/provisioning.zip"
  }
  tags = {
      Name = "Trabalho Final GCS"
  }
}


output "ip_wordpress" {
    value = "O IP público é ${module.web.ip_publico}"
}

/*
module "app_node" {
    source = "git:: https://github.com/jpcysne/infra-modulo-app-node.git"
    project_name = "app"
    db_name = "pg_db"
    db_user = "pg_user"
    db_password = "stupid_pass" # No mundo real, deve estar externalizado
    db_instance_type = "t2.micro"
    app_instance_type = "t2.micro"
    app_src_dir = "diretorio_src_app" #dir com o fonte da aplicação
}
output "endereco_app" {
    value = module.app_node.public_dns
}*/