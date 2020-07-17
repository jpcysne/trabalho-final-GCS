variable "bucket_name" {
    type = string
    description = "Nome do bucket a ser criado"
}
variable "upload_file" {
    type = map(string)
    description = "Mapa contendo as chaves 'src' e 'dest', com o caminho completo dos arquivos de origem e destino"
}
variable "tags" {
    type = map(string)
    description = "Tags aplicadas ao bucket e ao arquivo enviado"
}