# Create one VPC, two subnets (public and private) and security group.
# No DB is considered, however, if needed, another subnet is available for that purpose.


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
# Security group