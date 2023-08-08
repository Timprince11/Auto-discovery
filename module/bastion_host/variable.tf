variable  "instance_type" {
  default = "t2.medium"
}
variable "keypair" {
  default = "~/keypairs/capeuteam2"
}
variable "ami_redhat" {
  default = "ami-06e85d4c3149db26a"             #"ami-08e637cea2f053dfa"   us-east-1
} 

variable "bastion_sg" {}
variable "bastion_name" {}

variable "pub_sn_01" {}

variable "key" {}