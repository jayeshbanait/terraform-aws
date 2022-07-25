variable "environment" {
  #default = ""
  description = "The Deployment environment"
}

variable "vpc_cidr_base" {
 # default = ""
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  #default = ["", ""]
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  #default = ["", ""]
  type        = list
  description = "The CIDR block for the private subnet"
}

variable "region" {
  default     = ""
  description = "The region to launch the bastion host"
}
/*
variable "availability_zones" {
  value = [""]
  type        = list
  description = "The az that the resources will be launched"
}
*/

variable "app_name" {
  default = ""
}

variable "availability_zones" {
  default = ["", "", ""]
}

