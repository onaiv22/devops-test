region     = "eu-west-1"
vpc_cidr   = "192.168.0.0/16"
profile    = "devops-engineer"

//subnet configs
networks = {
   zones = [
      "eu-west-1a",
      "eu-west-1b",
   ]

   public_subnets = [
      "192.168.1.0/24",
      "192.168.2.0/24",
   ]

   subnet_name = [
      "web-server-1",
      "web-server-2",
   ]
}

alb-config = {
   name                   = "wipro"
   internal               = "true"
   listener_port          = "80"
}

idle_timeout = "600"

tags = {
  project_name      = "devop-test"
  owner             = "wipro"
  email             = "femi.okuta@wipro.com"
}


ami_id = "aki-02486376"

health_check_type = 2

name                  = "alb"
ami_name              = "centos"
instance_type         = "t2.micro"
ebs_optimized         = false
volume_type           = "gp2"
volume_delete         = true
internal              = true
description           = "default network ash configuration"
