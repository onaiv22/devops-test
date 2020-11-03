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
