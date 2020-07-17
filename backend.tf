resource "aws_s3_bucket" "backend_bucket" {
  bucket = "aula-terraform-jprubiogcs-backend"
  versioning {
    enabled = true
  }
  # Somente para a aula, não utilizar em produção!
  force_destroy = true
}
terraform {
  backend "s3" {
    bucket = "aula-terraform-jprubiogcs-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}