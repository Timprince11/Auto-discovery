#ASG Variables
variable "ami-name" {}
variable "target-instance" {}
variable "launch-configname" {}
variable "instance-type" {
 default = "t2.medium"
}
variable "sg_name" {}
variable "key_name" {}

variable "vpc-zone-identifier" {}

variable "target-group-arn" {}

variable "asg-group-name" {}

variable "asg-policy" {}

variable "prod-target-group-arn" {}
variable "prod-asg-policy" {}
variable "prod-asg-group-name" {}