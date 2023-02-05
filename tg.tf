# Create the target group

resource "aws_lb_target_group" "miniproject-target-group" {
  name     = "miniproject-target-group"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.miniproject_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}