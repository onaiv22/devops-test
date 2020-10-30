resource "aws_security_group" "alb_sg" {
  name        = "public-access"
  description = "Allows access to web-servers"
  vpc_id      = var.vpc_id

  tags = {
     Name = "wipro_alb-security-group"
  }
}
# ingress rules
resource "aws_security_group_rule" "alb_ingress" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow access on port 80 from public"
  security_group_id = aws_security_group.alb_sg.id
}

#egress rule
resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}
