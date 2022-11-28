output "arn" {
  value = aws_lb.alb.arn
}

output "dns_name" {
  value = aws_lb.alb.dns_name
}

output "https_listener_id" {
  value = aws_lb_listener.https.id
}

output "zone_id" {
  value = aws_lb.alb.zone_id
}
