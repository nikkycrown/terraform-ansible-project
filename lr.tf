# Create the listener

resource "aws_lb_listener" "miniproject-listener" {
  load_balancer_arn = aws_lb.miniproject-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.miniproject-target-group.arn
  }
}


# Create the listener rule

resource "aws_lb_listener_rule" "miniproject-listener-rule" {
  listener_arn = aws_lb_listener.miniproject-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.miniproject-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

# Attaching the target group to the load balancer

resource "aws_lb_target_group_attachment" "miniproject-target-group-attachment1" {
  target_group_arn = aws_lb_target_group.miniproject-target-group.arn
  target_id        = aws_instance.miniproject1.id
  port             = 80

}
 
resource "aws_lb_target_group_attachment" "miniproject-target-group-attachment2" {
  target_group_arn = aws_lb_target_group.miniproject-target-group.arn
  target_id        = aws_instance.miniproject2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "miniproject-target-group-attachment3" {
  target_group_arn = aws_lb_target_group.miniproject-target-group.arn
  target_id        = aws_instance.miniproject3.id
  port             = 80 
  
  }



