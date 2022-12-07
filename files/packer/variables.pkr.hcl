variable "aws_access_key" {
  type    = string
  default = "null"
}

variable "aws_secret_key" {
  type      = string
  default   = "null"
  sensitive = true
}

variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "region_name" {
  type = string
}

variable "ami_username" {
  type = string
}

variable "bash_dir" {
  type        = string
  description = "Path directory of bash scripts"
  default     = "modules/bash_scripts"
}
