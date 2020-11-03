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
