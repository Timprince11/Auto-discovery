variable "asname" {} 

variable "ass_pub" {
  default = true
} 

variable "ami" {
  default = "ami-0e4841c3bb7d47d69"     #"ami-08e637cea2f053dfa"   us-east-1
} 

variable "instance_type" {
  default = "t2.medium"
}  

variable "subnet_id" {} 

variable "ansible-sg-id" {} 

variable "IAM_Instance_Profile" {} 

variable "keys" {}  

variable "staging-MyPlaybook" {
  default = "~/scripts/staging-MyPlaybook.txt"
} 

variable "staging-discovery_script" {
  default = "~/scripts/staging-discovery.txt"
} 

variable "keypair" {
  default = "~/keypairs/capeuteam2.pub"
}

variable "prod-MyPlaybook" {
  default = "~/scripts/prod-MyPlaybook.txt"
} 

variable "prod-discovery_script" {
  default = "~/scripts/prod-discovery.txt"
}  

variable "license_key" {
  description = "New Relic License Key"
  type        = string
}