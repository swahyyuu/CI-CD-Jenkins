variable "account_id" {
  type        = string
  description = "Current account ID"
}

variable "vpc_id" {
  type        = string
  description = "VPC Id from another folder"
}

variable "subnet_id_1" {
  type        = string
  description = "Subnet ID of AZ A"
}

variable "subnet_id_2" {
  type        = string
  description = "Subnet ID of AZ B"
}

variable "subnet_id_3" {
  type        = string
  description = "Subnet ID of AZ C"
}

variable "sg_ec2" {
  type        = string
  description = "ID of sg for ec2 instance"
}

variable "elb_id" {
  type        = string
  description = "ID of Classic Load Balancer"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.medium"
}

variable "key_name" {
  type        = string
  description = "Name of Key Pair"
  default     = "terraform-test"
}

variable "bash_dir" {
  type        = string
  description = "Path directory of bash scripts"
  default     = "modules/bash_scripts"
}

variable "dockerhub_user" {
  type        = string
  description = "Username of Docker Hub"
  default     = "conan736"
}
