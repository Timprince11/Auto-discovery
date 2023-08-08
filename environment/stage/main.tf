module "staging-vpc" {
  source            = "../../module/vpc"
  vpc_name          = "PADUS1_VPC"
  pubsn1_name  = "stage-PADUS1-pub-subnet1"
  pubsn2_name  = "stage-PADUS1-pub-subnet2"
  privsn1_name = "stage-PADUS1-prvt-subnet1"
  privsn2_name = "stage-PADUS1-prvt-subnet2"
}

module "staging-keypair" {
  source = "../../module/keypair"
  keypair_name = "capadus1"
}

module "staging-IAM" {
  source = "../../module/IAM"
  rolename = "ansible-role"
  policy = "ansible-policy"
  profilename = "ansible-profile"
}

module "staging-security-group" {
  source = "../../module/security-group"
  VPC_ID = module.staging-vpc.VPC_ID
  jenkins-sg = "jenkins-sg"
  bastion = "bastion-sg"
  sonar-SG = "sonar-sg"
  ansible-sg = "ansible-sg"
  docker-SG = "docker-sg"
  rds-sg = "rds-sg"
}

# module "staging_route53" {
#   source      = "../../module/route53"
#   domain_name = "www.codedollars.com"
#   dns_name    = module.staging-high_availability.aws_lb_asg_dns
#   zone_id     = module.staging-high_availability.aws_lb_asg_zone_id
# }

module "staging-bastion_host" {
  source       = "../../module/bastion_host"
  pub_sn_01    = module.staging-vpc.PUBSN1_ID
  bastion_sg   = module.staging-security-group.Bastion-SG-ID
  bastion_name = "bastion_host"
  key          = module.staging-keypair.key_id
}

module "staging-ansible_server" {
  source               = "../../module/ansible_server"
  subnet_id            = module.staging-vpc.PRSN1_ID
  ansible-sg-id        = module.staging-security-group.Ansible-SG-ID
  IAM_Instance_Profile = module.staging-IAM.IAM_Instance_Profile
  keys                 = module.staging-keypair.key_id
  asname               = "Ansible_Server"
}

module "staging-jenkins_server" {
  source        = "../../module/jenkins_server"
  subnet_id     = module.staging-vpc.PRSN1_ID
  jenkins-sg-id = module.staging-security-group.Jenkins-SG_ID
  keypair       = module.staging-keypair.key_id
  jenkinsname   = "Jenkins_Server"
}

module "staging-sonarqube" {
  source                 = "../../module/sonarqube"
  subnet_id              = module.staging-vpc.PUBSN1_ID
  server-Sonarqube       = "sonarqube"
  vpc_security_group_ids = module.staging-security-group.Sonar-SG-ID
  key                    = module.staging-keypair.key_id
}

module "staging-docker" {
  source                 = "../../module/docker"
  instance_type          = "t2.medium"
  ami                    = "ami-0e4841c3bb7d47d69"          #"ami-08e637cea2f053dfa" us-east-1
  subnet_id              = module.staging-vpc.PRSN2_ID 
  key_name               = module.staging-keypair.key_id
  vpc_security_group_ids = module.staging-security-group.Docker-SG-ID
  servername             = "staging-docker-host"
}

module "staging-high_availability" {
  source = "../../module/high-availability"
  jenkins-server = module.staging-jenkins_server.jenkins_server
  pub-subnet-name = [module.staging-vpc.PUBSN1_ID, module.staging-vpc.PUBSN2_ID]
  PADUS1-Jenkins-SG = [module.staging-security-group.Jenkins-SG_ID]
  vpc-name = module.staging-vpc.VPC_ID
  PADUS1-Docker-SG = [module.staging-security-group.Docker-SG-ID]
  prod-docker-lb-name = "prod-docker-loadblancer"
  prod-docker-tg-lb =  "prod-docker-target-group"
  docker-lb-name = "docker-loadbalancer"
  docker-tg-lb = "docker-target-group"
  jenkins-lb-name = "jenkins-loadbalancer"
  jenkins-tg-name = "jenkins-target-group"
}

# module "staging-AMI" {
#   source          = "../../module/AMI"
#   ami-name = "PADUS1-ami"
#   launch-configname = "PADUS1-lc"
#   key_name        = module.staging-keypair.key_id
#   sg_name = module.staging-security-group.Docker-SG-ID
#   target-instance = module.staging-docker.docker_id
#   vpc-zone-identifier = [module.staging-vpc.PRSN1_ID, module.staging-vpc.PRSN2_ID]
#   target-group-arn = module.staging-high_availability.aws_lb_arn
#   asg-group-name = "staging-PADUS1_asg"
#   prod-asg-group-name = "prod-PADUS1_asg"
#   asg-policy = "staging-PADUS1-policy"
#   prod-asg-policy = "prod-PADUS1-policy"
#   prod-target-group-arn = module.staging-high_availability.prod-docker-arn
#   depends_on = [time_sleep.wait_180_seconds]
# }

# resource "time_sleep" "wait_180_seconds" {
#   depends_on = [module.staging-docker]
#   create_duration = "180s"
# }

# module "staging-RDS" {
#   source    = "../../module/RDS"
#   subnet_id = [module.staging-vpc.PADUS1_prvt_sn_01, module.staging-vpc.PADUS1_prvt_sn_02]
#   rds_sg    = module.staging-security-group.RDS_ID
# }