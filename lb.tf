# Create an Application Load Balancer

resource "aws_lb" "miniproject-load-balancer" {
  name               = "miniproject-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.miniproject-load_balancer_sg.id]
  subnets            = [aws_subnet.miniproject-public-sub1.id, aws_subnet.miniproject-public-sub2.id]
  #enable_cross_zone_load_balancing = true
  enable_deletion_protection = false
  depends_on                 = [aws_instance.miniproject1, aws_instance.miniproject2, aws_instance.miniproject3]
}
