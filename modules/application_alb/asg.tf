data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "asg_launch_config" {
  name_prefix                 = "launch-config-"
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = "mykey-pair"
  user_data                   = file("bootstrap.sh")
  security_groups             = [aws_security_group.alb_tg_sg.id]
  iam_instance_profile        = arn:aws:iam::636214711014:role/wipro-role

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "alb_asg" {
  name                      = "alb-asg"
  launch_configuration      = aws_launch_configuration.asg_launch_config.name
  min_size                  = 2
  max_size                  = 4
  vpc_zone_identifier       = var.balancer_subnets
  target_group_arns         = [aws_lb_target_group.alb_asg_target.arn]

  lifecycle {
    create_before_destroy = true
  }
}
