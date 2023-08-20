# Create one VPC, two subnets (public and private) and security group.
# The private subnet, has no internet access. It is for the sake of correctness included. Not used in this excercise.
# In the private zone, a DB would be placed there connecting to the webserver on the public subnet.


# VPC
resource "aws_vpc" "backbone" {
 cidr_block = var.vpc_netrange
 enable_dns_support = var.dnssupport
 enable_dns_hostnames = var.dnshostnames

 tags = {
   Name = "Tocos VPC"
 }
}


# Subnet
resource "aws_subnet" "tocos-public_subnet" {
 vpc_id     = aws_vpc.backbone.id
 cidr_block = var.public_subnet
 map_public_ip_on_launch = var.map-public-ip
 
 tags = {
   Name = "Public Subnet"
 }
}
 
resource "aws_subnet" "tocos-private_subnet" {
 vpc_id     = aws_vpc.backbone.id
 cidr_block = var.private_subnet
 
 tags = {
   Name = "Private Subnet"
 }
}


# Internet gateway
resource "aws_internet_gateway" "tocos-gw" {
 vpc_id = aws_vpc.backbone.id
 
 tags = {
   Name = "Tocos VPG GW"
 }
}

# Security group
resource "aws_security_group" "tocos-security_group" {
  vpc_id       = aws_vpc.backbone.id
  name         = "Tocos Security Group"
  description  = "Tocos Security Group"
  
  # allow ingress of port 8300 / my service
  ingress {
    cidr_blocks = var.ingress-network
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
  } 
  # allow ingress to ssh
  ingress {
    cidr_blocks = var.ingress-network
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  # allow ingress to grafana
  ingress {
    cidr_blocks = var.ingress-network
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress-network
  }
  tags = {
   Name = "Tocos Security Group"
   Description = "Tocos Security Group"
  }
}

# Routing table (Default GW)

resource "aws_route_table" "tocos-route" {
 vpc_id = aws_vpc.backbone.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.tocos-gw.id
 }
 
 tags = {
   Name = "Tocos Route Table"
 }
}