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
    max_instances         = 2
    capacity              = 3
  }
}

variable "ingress_rules" {
  type    = "list"
  default = []
}

variable "egress_rules" {
  type    = "list"
  default = []
}
