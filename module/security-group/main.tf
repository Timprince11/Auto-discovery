 # Create jenkins Security Group
resource "aws_security_group" "PADUS1-jenkins-SG" {
  name        = var.jenkins-sg
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "jenkins port for lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
   cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "jenkins port from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
   cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = var.jenkins-sg
  }
}

#SECURITY GROUP FOR THE DOCKER HOST
resource "aws_security_group" "PADUS1-docker-SG"  {
  name        = var.docker-SG
  description = "Allow TLS Inbound"
  vpc_id      = var.VPC_ID


  ingress {
    description = "allow ssh acess"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

ingress {
    description = "allow docker port  acess"
    from_port   = 8085
    to_port     = 8085
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "allow lb  port acess"
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name =  var.docker-SG
  }
}

#Create Ansible Security Group
resource "aws_security_group" "PADUS1-Ansible-SG" {
  name        = var.ansible-sg
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = var.ansible-sg
  }
}

#Create Sonarqube Security Group
resource "aws_security_group" "PADUS1-sonar-SG" {
  name        = var.sonar-SG
  description = "Allow inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "TLS from VPC"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sonar-SG
  }
}

# Security group for Bastion Host
resource "aws_security_group" "PADUS1-bastion-SG" {
  name        = var.bastion
  description = "Allow traffic for ssh"
  vpc_id      = var.VPC_ID

  ingress {
    description = "Allow ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion
  }
}

#SECURITY GROUP FOR RDS
resource "aws_security_group" "PADUS1-RDS-SG" {
  name        =  var.rds-sg
  description = "Allow TLS Inbound"
  vpc_id      = var.VPC_ID


  ingress {
    description = "allow ssh acess"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name =  var.rds-sg
  }
}