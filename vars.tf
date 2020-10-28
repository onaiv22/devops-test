variable "profile" {}
variable "region" {
   type    = string
   default = "eu-west-1"
}
variable "vpc_cidr" {
   type = string
   default = "192.168.0.0/16"
}
variable "networks" {
   type = map(any)
}



output "vpc_id" {
  value = module.vpc.vpc_id
}
