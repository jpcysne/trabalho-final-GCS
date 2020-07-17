output "url_arquivo" {
    value = "${aws_s3_bucket.ansible_bucket.bucket_domain_name}/${aws_s3_bucket_object.upload.id}"
}