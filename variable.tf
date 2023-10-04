variable "ec2_ami" {
  description = "The AMI to base the meachine from"
  type        = string
  default     = "ami-04b1c88a6bbd48f8e"
}

variable "ec2_instance_type" {
  description = "The Instance type that the machine should be"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "The Pem Key Name"
  type        = string
}

variable "default_tags" {
  description = "Default Tags for instances"
  type        = map(any)
  default = {
    "Name" = "HR App"
  }
}

variable "availability_zone_a" {
  default = "eu-west-1a"
}
variable "availability_zone_b" {
  default = "eu-west-1b"
}
variable "availability_zone_c" {
  default = "eu-west-1c"
}

# variable "bucket" {

# }

# variable "key" {

# }

variable "db_username" {

}
variable "db_password" {

}