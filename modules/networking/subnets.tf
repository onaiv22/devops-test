resource "aws_subnet" "public_subnets" {
  count                   = length(var.networks["public_subnets"])
  availability_zone       = element(var.networks["zones"], count.index)
  cidr_block              = element(var.networks["public_subnets"], count.index)
  map_public_ip_on_launch = true
  vpc_id                  = var.vpc_id

  tags = {
     name = element(var.networks["subnet_name"], count.index)
  }

}
