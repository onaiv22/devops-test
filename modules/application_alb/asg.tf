resource "aws_launch_configuration" "asg_launch_config" {
  name_prefix          = "asg_launch_config"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  key_name             = "mykey-pair"
  security_groups      = [aws_security_group.alb_tg_sg.id]
  user_data            = "${file("bootstrap.sh")}"
  ebs_optimized        = lookup(var.target, "ebs_optimized", false)

  root_block_device {
    delete_on_termination = lookup(var.target, "volume_delete", true)
    volume_size           = lookup(var.target, "volume_size", 16)
    volume_type           = lookup(var.target, "volume_type", "gp2")
  }

  lifecycle {
    create_before_destroy = true
  }
}
