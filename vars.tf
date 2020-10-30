variable "profile" {}
variable "idle_timeout" {}

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

variable "alb-config" {
  type = map(string)

  default = {
    name                   = "wipro"
    internal               = "false"
    listener_port          = "80"
  }
}



output "vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_gw" {
   value = module.vpc.vpc_gw
}
