output "Jenkins-SG_ID" {
  value = aws_security_group.PADUS1-jenkins-SG.id
}

output "Docker-SG-ID" {
  value = aws_security_group.PADUS1-docker-SG.id
}

output "Ansible-SG-ID" {
  value = aws_security_group.PADUS1-Ansible-SG.id
}

output "Sonar-SG-ID" {
  value = aws_security_group.PADUS1-sonar-SG.id
}

output "Bastion-SG-ID" {
  value = aws_security_group.PADUS1-bastion-SG.id
}

output "RDS_ID" {
  value = aws_security_group.PADUS1-RDS-SG.id
}