variable "vpc_id" {}
variable "instance_type" {}
variable "balancer_subnets" {
  type = list(string)
}

variable "idle_timeout" {
  default = 60
}

variable "ami_id" {}

variable "alb-config" {
  type = map(string)

  default = {
    name                   = "wipro"
    internal               = "false"
    listener_port          = "80"
  }
}
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
    health_check_type     = 2
    volume_size           = 10
    volume_type           = "gp2"
    volume_delete         = true
    internal              = true
    description           = "default network ash configuration"
    min_instances         = 2
    max_instances         = 2
    capacity              = 3
  }
}

output "alb_sg_id" {
   value = aws_security_group.alb_sg.*.id
}

output "tg_sg_id" {
   value = aws_security_group.alb_tg_sg.*.id
}
