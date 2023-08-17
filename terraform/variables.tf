variable "vpc_netrange" {
    type        = string
    default     = "172.31.0.0/16"
    description = "The basic VPC network range"
}
variable "dnssupport" {
    type    = bool
    default = true
}
variable "dnshostnames" {
    type    = bool
    default = true
}
variable "public_subnet" {
    type     = string
    description = "Public Subnet"
    default     = "172.31.0.0/20"
}
 
variable "private_subnet" {
    type        = string
    description = "Private Subnet"
    default     = "172.31.16.0/20" 
}

variable "map-public-ip" {
    type = bool
    default = true
}

variable "availability-zone" {
    type = string
    default = "us-east-1a"
}

variable "ingress-network" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "egress-network" {
    type = list
    default = [ "0.0.0.0/0" ]
}