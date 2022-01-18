resource "aws_lb_target_group" "ip-example" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

resource "aws_lb" "sks" {
    name = "sks"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.myapp-elb-securitygroup.id]
    subnets = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.sks.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
  }
}

