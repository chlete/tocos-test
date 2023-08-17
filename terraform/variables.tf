variable "vpc_netrange" {
  default     = "10.10.0.0/16"
  description = "The basic VPC network range"
}
variable "dnssupport" {
    default = true
}
variable "dnshostnames" {
    default = true
}