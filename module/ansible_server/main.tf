# Ansible Instance

resource "aws_instance" "Ansible_Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.keys
  vpc_security_group_ids      = [var.ansible-sg-id]
  associate_public_ip_address = var.ass_pub
  subnet_id                   = var.subnet_id
  iam_instance_profile        = var.IAM_Instance_Profile
  user_data                   = <<-EOF
#!/bin/bash 
sudo yum update -y 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
sudo yum install unzip -y 
unzip awscliv2.zip 
sudo ./aws/install
sudo yum install wget -y 
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
sudo yum install epel-release-latest-7.noarch.rpm -y 
sudo yum update -y 
sudo yum install git python python-devel python-pip ansible -y
sudo yum install yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user   
sudo echo "${file(var.staging-MyPlaybook)}" >> /etc/ansible/Staging-MyPlaybook.yml 
sudo echo "${file(var.staging-discovery_script)}" >> /etc/ansible/staging-discovery.sh
sudo echo "${file(var.prod-MyPlaybook)}" >> /etc/ansible/Prod-MyPlaybook.yml 
sudo echo "${file(var.prod-discovery_script)}" >> /etc/ansible/prod-discovery.sh  
sudo echo "${file(var.keypair)}" >> /etc/ansible/key.pem  
sudo chown ec2-user:ec2-user /etc/ansible 
sudo chmod 400 /etc/ansible/key.pem 
sudo chmod 755 /etc/ansible/staging-discovery.sh
sudo chmod 755 /etc/ansible/prod-discovery.sh    
#NEW RELIC SETUP
echo "license_key: 605c516f995f5c58bb7ec47f2d3969917821NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y --nobest
sudo hostnamectl set-hostname ansible
sudo reboot
  EOF 

  tags = {
    Name = var.asname
  }
}