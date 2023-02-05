 resource "aws_lb_target_group" "target_group" {
   name = "assignmentTarget"
   port = 80
   target_type = "instance"
   protocol    = "HTTP"
   vpc_id      = aws_vpc.myVpc.id
 }
 resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = length(aws_instance.assignment.*.id) == 3 ? 3 : 0
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = element(aws_instance.assignment.*.id, count.index)
}
resource "aws_lb" "lb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_HTTP_and_SSH.id]
  subnets            = [for subnet in aws_subnet.public1 : subnet.id]
}
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn

  }

  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}
