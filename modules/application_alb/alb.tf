data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "elb_logs" {
  bucket = "alb-log-bucket-wipro"
  acl    = "private"

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::alb-log-bucket-wipro/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_alb" "alb" {
  name            = var.alb-config["name"]
  internal        = var.alb-config["internal"]
  subnets         = var.balancer_subnets
  security_groups = [aws_security_group.alb_sg.id]
  idle_timeout    = var.idle_timeout

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.elb_logs.bucket
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
