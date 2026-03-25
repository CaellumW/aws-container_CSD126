# make a variable named aws_region set to us-east-1
variable "aws_region" {
  type = string
  default = "us-east-1"
}
# var named ami_id, set to the id your ec2 instance uses
variable "ami_id" {
  type = string
  default = "i-0ef82ac99c93ff213" #this is the instance id of my xpix server instance
}

# var names instance_profile_name set to 'LabInstanceProfile'
variable "instance_profile_name" {
  type = string
  default = "LabInstanceProfile"
}
# 