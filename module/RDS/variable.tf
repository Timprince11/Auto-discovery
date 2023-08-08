
variable "db_name" {
  default = "padusdb"

}

variable "db_username" {
  default = "petclinic"

}

variable "db_passwd" {
  default = "petclinic"

}

variable "identifier" {}


variable "rds_name" {}

variable "subnet_id" {}


variable "mysql_port" {
  default     = 3306
}


variable "rds_sg" {}
