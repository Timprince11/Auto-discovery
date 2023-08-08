output "aws_lb" {
  value = aws_lb.PADUS1-alb.id
}

output "aws_lb_dns" {
  value = aws_lb.PADUS1-alb.dns_name
}

output "aws_lb_arn" {
  value = aws_lb_target_group.PADUS1-asg-target-group.arn
}

output "aws_lb_asg" {
  value = aws_lb.PADUS1-asg.id
}

output "aws_lb_asg_dns" {
  value = aws_lb.PADUS1-asg.dns_name
}

output "aws_lb_asg_zone_id" {
  value = aws_lb.PADUS1-asg.zone_id
}  

output "prod-docker-lb" {
  value = aws_lb.Prod-PADUS1-asg.dns_name
}

output "prod-docker-lb-zone-id" {
  value = aws_lb.Prod-PADUS1-asg.zone_id
}

output "prod-docker-id" {
  value = aws_lb.Prod-PADUS1-asg.id
}

output "prod-docker-arn" {
  value = aws_lb_target_group.Prod-PADUS1-asg-target-group.arn
}
