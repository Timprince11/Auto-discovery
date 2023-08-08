variable "VPC_ID" {}

variable "all_cidr" {
  default = "0.0.0.0/0"
}
variable "docker-SG" {}
variable "jenkins-sg" {}
variable "ansible-sg" {}
variable "sonar-SG" {}
variable "bastion" {}
variable "rds-sg" {}