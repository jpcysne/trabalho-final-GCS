variable "tipo_instancia" {
    type = string
    default = "t2.micro"
}
variable "ami" {
    type = map
    default = {
        "us-east-1" = "ami-0ac80df6eff0e70b5"
    }
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "instanceTenancy" {
    default = "default"
}

variable "availabilityZone" {
     default = "us-east-1a"
}
variable "mapPublicoIP" {
    default = true
}
variable "publicodestCIDRblock" {
    default = "0.0.0.0/0"
}

variable "publicoCIDRblock" {
    default = "10.0.1.0/24"
}
variable "privadoCIDRblock" {
    default = "10.0.2.0/24"
}
variable "dnsHostNames" {
    default = true
}
variable "dnsSupport" {
    default = true
}