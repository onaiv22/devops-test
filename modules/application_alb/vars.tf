variable "vpc_id" {}

variable "balancer_subnets" {
  type = list(string)
}
variable "idle_timeout" {
  default = 60
}


variable "alb-config" {
  type = map(string)

  default = {
    name                   = "wipro"
    internal               = "false"
    listener_port          = "80"
  }
}

//variable "identity_alb_tg_config" {
  //type = map(string)

  //default = {
  //  forward_port              = "8443"
    //forward_protocol          = "HTTPS"
    //sticky_enabled            = "true"
    //cookie_duration           = 1800
    //dereg_delay               = 100
    //healthcheck_path          = "/info/health"
    //healthcheck_port          = "traffic-port"
    //healthcheck_protocol      = "HTTPS"
    //healthy_threshold         = 3
    //unhealthy_threshold       = 10
    //timeout_threshold_seconds = 5
    //healthcheck_interval      = 10
  //}
//}
