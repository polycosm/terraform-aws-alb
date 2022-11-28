/* Create an application load balancer.
 */
resource "aws_lb" "alb" {
  load_balancer_type = "application"
  internal           = var.internal
  name               = var.name
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.internal ? var.network.private_subnets : var.network.public_subnets

  tags = {
    Name = var.name
  }
}

/* By default, redirect http (port 80) traffic to https (port 443).
 */
resource "aws_lb_listener" "http_redirect_to_https" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

/* Add a default https (port 433) listener that returns a 404.
 */
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.widlcard_certificate.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{\"status\": 404}"
      status_code  = 404
    }
  }
}
