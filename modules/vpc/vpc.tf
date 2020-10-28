resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
     Name = "wipro"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
   vpc_id = aws_vpc.main.id

   tags = {
      Name = "wipro-internet-gateway"
   }
}
