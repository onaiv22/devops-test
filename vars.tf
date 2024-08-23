# variable "profile" {}
variable "idle_timeout" {}
variable "instance_type" {}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
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
variable "ami_id" {}
variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = "300"
}

variable "target" {
  type = map(any)

  default = {
    name                  = "alb"
    ami_name              = "centos"
    instance_type         = "t2.micro"
    ebs_optimized         = false
    volume_size           = 10
    volume_type           = "gp2"
    volume_delete         = true
    internal              = true
    description           = "default network ash configuration"
    min_instances         = 2
    max_instances         = 4
    capacity              = 4
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_gw" {
   value = module.vpc.vpc_gw
}

output "alb_sg" {
   value = module.alb.alb_sg_id
}

output "tg_sg" {
   value = module.alb.tg_sg_id
}

output "subnet_id" {
   value = module.subnets.subnet_id
}
