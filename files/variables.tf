variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-southeast-1"
}

variable "access_key" {
  type        = string
  description = "This is access key of AWS account"
}

variable "secret_key" {
  type        = string
  description = "This is secret key of AWS account"
}