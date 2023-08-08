output "SONAR_IP" {
value = aws_instance.sonar_node.public_ip
 description = "SONAR public IP"
}
