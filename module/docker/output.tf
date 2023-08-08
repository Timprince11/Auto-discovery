output "Docker_IP" {
  value       = aws_instance.docker_host.private_ip
  description = "Docker private IP"
}
output "docker_id" {
  value       = aws_instance.docker_host.id
  description = "Docker Instance ID"
}