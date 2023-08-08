output "Route53_name" {
    value = aws_route53_record.UST1_lb.name
  }
  
  output "name_servers" {
    value = aws_route53_zone.UST1_zone.name_servers
  }