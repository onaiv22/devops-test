data "template_file" "alb_logs_policy" {
  template = <<eof
        {
             "Sid": "Stmt1604063313517",
                "Action": [
                    "s3:PutObject"
                ],
                "Effect": "Allow",
                "Resource": "${aws_s3_bucket.alb-logs.id}/*",
                "Principal": {
                    "AWS": [
                      "${aws_alb.alb.arn}"
                    ]
                }
        }
eof
}

resource "aws_s3_bucket_policy" "b-policy" {
  bucket = aws_s3_bucket.alb-logs.id

  policy = data.template_file.alb_logs_policy.rendered
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "bucket-access-logs-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "alb-logs" {
  bucket = "alb-logs-bucket-wipro"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}

resource "aws_alb" "alb" {
  name            = var.alb-config["name"]
  internal        = var.alb-config["internal"]
  subnets         = var.balancer_subnets
  security_groups = [aws_security_group.alb_sg.id]
  idle_timeout    = var.idle_timeout

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.alb-logs.id
    enabled = "true"
  }

  tags = {
     Name = "wipro-alb"
  }
}

resource "aws_lb_target_group" "alb_asg_target" {
  name                          = "backend-servers"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  load_balancing_algorithm_type = "round_robin" //defaults to round_robin
  target_type                   = "instance"    //defaults to instance

  deregistration_delay          = 300    //how long the lb waits before changing state of deregistering target from draining to unused//

  stickiness {
    type            = "lb_cookie"      //defaults to lb_cookie
    cookie_duration = 86400 //default to 86400 - time period in seconds during which requests from a client should be routed to the same target
    enabled         = "true"  //default is true
  } // for tcp protocols for target groups enabled must be false
  health_check {
    healthy_threshold   =  "3"
    unhealthy_threshold =  "10"
    timeout             =  "5"
    interval            =  "10"
    path                =  "/info/health"
    port                =  80
    protocol            =  "HTTP"
  }

  tags = {
     Name = "alb-tg"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_asg_target.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "alb_listener_rule" {
  depends_on   = [aws_lb_target_group.alb_asg_target]
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_asg_target.id
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

//{
  //"Id": "Policy1604063315754",
  //"Version": "2012-10-17",
  //"Statement": [
    //{
    //  "Sid": "Stmt1604063313517",
    //  "Action": [
    //    "s3:ListBucket",
    //    "s3:PutObject"
    //  ],
    //  "Effect": "Allow",
    //  "Resource": "${aws_s3_bucket.alb-logs.id}"
    //  "Principal": {
    //    "AWS": [
    //      "${aws_alb.alb.arn}"
    //    ]
    //  }
    //}
  //]
//}
