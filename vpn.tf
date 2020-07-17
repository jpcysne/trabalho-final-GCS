resource "aws_vpc" "VPC" {
  instance_tenancy     = var.instanceTenancy
  cidr_block           = var.vpcCIDRblock
  enable_dns_hostnames = var.dnsHostNames 
  enable_dns_support   = var.dnsSupport 
  
tags = {
    Name = "VPC Final GCS"
    }
}

resource "aws_subnet" "Public_subnet" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.publicoCIDRblock
  map_public_ip_on_launch = var.mapPublicoIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Public_Subnet"
    }
}

resource "aws_subnet" "Private_subnet" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.privadoCIDRblock
  map_public_ip_on_launch = var.mapPublicoIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Private_Subnet"
    }
}


resource "aws_network_acl" "Public_NACL" {
  vpc_id = aws_vpc.VPC.id
  subnet_ids = [ aws_subnet.Public_subnet.id ]
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.publicdestCIDRblock 
    from_port  = 22
    to_port    = 22
  }
  
 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.publicdestCIDRblock
    from_port  = 22 
    to_port    = 22
  }
  
tags = {
    Name = "Public NACL"
    }
}


resource "aws_internet_gateway" "IGW_teste" {
 vpc_id = aws_vpc.VPC.id
 tags = {
        Name = "Internet gateway "
    }
} 
resource "aws_route_table" "Public_RT" {
 vpc_id = aws_vpc.VPC.id
 tags = {
        Name = "Public Route table"
    }
} 


resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.Public_RT.id
  destination_cidr_block = var.publicodestCIDRblock
  gateway_id             = aws_internet_gateway.IGW_teste.id
}

resource "aws_route_table_association" "Public_association" {
  subnet_id      = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.Public_RT.id
}