resource "aws_instance" "bastion_host" {
  ami                         = var.ami_redhat
  instance_type               = var.instance_type
  key_name                    = var.key
  subnet_id                   = var.pub_sn_01
  vpc_security_group_ids      = [var.bastion_sg]
  associate_public_ip_address = true  
  user_data                   = <<-EOF
  #!/bin/bash     
  echo "${file(var.keypair)}" >> /home/ec2-user/capeuteam2
  chmod 400 capeuteam2
  sudo hostnamectl set-hostname Bastion 
  EOF
    tags = {
        name = var.bastion_name
    }
}


