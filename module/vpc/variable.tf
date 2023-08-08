variable "region" {
  default = "us-west-2"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "VPC_CIDRPUB1" {
  default = "10.0.0.0/24"
}

variable "VPC_CIDRPUB2" {
  default = "10.0.1.0/24"
}



variable "VPC_CIDRPRIV1" {
  default = "10.0.2.0/24"
}

variable "VPC_CIDRPRIV2" {
  default = "10.0.3.0/24"
}


variable "AZ2" {
  default = "us-west-2b"
}

variable "AZ1" {
  default = "us-west-2a"
}


variable "all_cidr" {
  default = "0.0.0.0/0"
}

variable "vpc_name" {}

variable "pubsn1_name" {}

variable "pubsn2_name" {}


variable "privsn1_name" {}

variable "privsn2_name" {}

variable "igw_name" {
  default = "PADUS1_IGW"
}

variable "eip_name" {
  default = "PADUS1_EIP"
}

variable "pubrt_name" {
  default = "PADUS1_PUBRT"
}

variable "privrt_name" {
  default = "PADUS1_PRIVRT"
}

variable "ng_name" {
  default = "PADUS1_NATGW"
}