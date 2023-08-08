variable "ami" {
  default = "ami-095413544ce52437d"           #"ami-00874d747dde814fa"      us-east-1
}

variable "instance_type_t2" {
  default = "t3.medium"
}

variable "subnet_id" {}


variable "key" {}


variable "associate_public_ip_address" {
  default = "true"
}

variable "vpc_security_group_ids" {}

variable "server-Sonarqube" {} 

variable "license_key" {
  description = "New Relic License Key"
  type        = string
}

