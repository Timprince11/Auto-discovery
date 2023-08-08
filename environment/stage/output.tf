output "ansible_priv_ip" {
  value = module.staging-ansible_server.ansible_priv
}

output "jenkins_priv_ip" {
  value = module.staging-jenkins_server.jenkins_priv
}

output "bastion_host_ip" {
  value = module.staging-bastion_host.bastion_host_ip
}

output "sonar_host_ip" {
  value = module.staging-sonarqube.SONAR_IP
}

output "docker_host_ip" {
  value = module.staging-docker.Docker_IP
} 

# output "name_servers" {
#   value = module.staging_route53.name_servers
# }

output "jenkins_dns" {
    value = module.staging-high_availability.aws_lb_dns
}

# output "docker_dns" {
#     value = module.staging-high_availability.aws_lb_asg_dns
# }

output "prod-docker_dns" {
    value = module.staging-high_availability.prod-docker-lb
}