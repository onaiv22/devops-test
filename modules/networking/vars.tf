variable "region" {}
variable "cidr_block" {}
variable "vpc_id" {}
# variable "profile" {}
variable "networks" {
   type = map(any)
}
variable "gw_id" {}

output "subnet_id" {
   value = aws_subnet.public_subnets.*.id
}
