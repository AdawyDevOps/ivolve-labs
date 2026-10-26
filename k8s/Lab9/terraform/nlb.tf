resource "aws_lb" "api" {
  name                             = "${var.project_name}-api-nlb"
  load_balancer_type               = "network"
  internal                         = true
  subnets                          = aws_subnet.public[*].id
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.project_name}-api-nlb"
  }
}

resource "aws_lb_target_group" "api" {
  name               = "${var.project_name}-api-tg"
  port               = 6443
  protocol           = "TCP"
  target_type        = "ip"
  vpc_id             = aws_vpc.main.id
  preserve_client_ip = "false"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "masters" {
  count            = 3
  target_group_arn = aws_lb_target_group.api.arn
  target_id        = aws_instance.master[count.index].private_ip
  port             = 6443
}

resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.api.arn
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}
