resource "aws_lb" "hrapp_lb" {
  name               = "hrapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.hrapp_sg.id]
  subnets            = [aws_subnet.pub_eu_west_1_a.id, aws_subnet.pub_eu_west_1_b.id]
}

resource "aws_lb_target_group" "hrapp_tg" {
  name     = "hrapp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.hrapp_vpc.id

  health_check {
    path = "/about"
    protocol = "HTTP"
    port     = "80"
    interval = 30
    timeout  = 5
  }
}

resource "aws_lb_listener" "hrapp_lb_listener" {
  load_balancer_arn = aws_lb.hrapp_lb.arn
  port             = "80"
  protocol         = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hrapp_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "hrapp_tg_attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.hrapp_tg.arn
  target_id        = aws_instance.hrapp_node[count.index].id
}
