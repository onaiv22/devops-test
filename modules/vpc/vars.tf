variable "region" {}
variable "cidr_block" {}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_gw" {
   value = aws_internet_gateway.internet_gateway.id
}
