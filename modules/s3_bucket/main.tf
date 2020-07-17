resource "aws_s3_bucket" "ansible_bucket" {
  bucket = var.bucket_name #"ansible-config-jprubiogcs"
  acl    = "public-read"
  tags =  var.tags
}
resource "aws_s3_bucket_object" "upload" {
  bucket = aws_s3_bucket.ansible_bucket.bucket
  key    = var.upload_file["dest"] #"ansible/provisioning.zip"
  source = var.upload_file["src"] #"ansible/provisioning.zip"
  acl = "public-read"
  tags =  var.tags
}