output "ansible_priv" {
  value = aws_instance.Ansible_Server.private_ip
}