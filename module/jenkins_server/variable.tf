variable "jenkinsname" {} 

variable "ass_pub" {
  default = true
} 

variable "ami" {
  default = "ami-0e4841c3bb7d47d69"         #"ami-0aa7d40eeae50c9a9"     us-east-1
} 

variable "instance_type" {
  default = "t2.medium"
}  

variable "subnet_id" {} 

variable "jenkins-sg-id" {} 

variable "keypair" {} 

variable "license_key" {
  description = "New Relic License Key"
  type        = string
}