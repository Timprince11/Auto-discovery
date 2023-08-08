output "jenkins_priv" {
  value = aws_instance.jenkins_server.private_ip
}

output "jenkins_server" {
  value = aws_instance.jenkins_server.id
}