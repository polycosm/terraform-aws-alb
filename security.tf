/* Create a security group for the load balancer.
 */
resource "aws_security_group" "alb" {
  name   = var.name
  vpc_id = var.network.vpc_id

  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

/* Allow inbound http (port 80).
 */
resource "aws_security_group_rule" "allow_inbound_http" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb.id
  to_port           = 80
  type              = "ingress"
}

/* Allow inbound https (port 433).
 */
resource "aws_security_group_rule" "allow_inbound_https" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb.id
  to_port           = 443
  type              = "ingress"
}

/* Allow all outbound.
 */
resource "aws_security_group_rule" "allow_outbound_all" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.alb.id
  to_port           = 0
  type              = "egress"
}
