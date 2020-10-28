variable "region" {}
variable "cidr_block" {}




output "vpc_id" {
  value = aws_vpc.main.id
}
