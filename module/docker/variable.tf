variable "instance_type" {}

variable "ami" {}

variable "subnet_id" {}

variable "key_name" {}

variable "vpc_security_group_ids" {}

variable "servername" {} 

variable "license_key" {
  description = "New Relic License Key"
  type        = string
}