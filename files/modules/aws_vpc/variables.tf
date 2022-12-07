variable "cidr_vpc" {
  type        = string
  description = "CIDR Block of VPC"
  default     = "10.50.0.0/16"
}

variable "cidr_subnet_1" {
  type        = string
  description = "CIDR Block of AZ A"
  default     = "10.50.10.0/24"
}

variable "cidr_subnet_2" {
  type        = string
  description = "CIDR Block of AZ B"
  default     = "10.50.11.0/24"
}

variable "cidr_subnet_3" {
  type        = string
  description = "CIDR Block of AZ C"
  default     = "10.50.12.0/24"
}

variable "az_subnet_1" {
  type        = string
  description = "Availability Zone A"
  default     = "ap-southeast-1a"
}

variable "az_subnet_2" {
  type        = string
  description = "Availability Zone B"
  default     = "ap-southeast-1b"
}

variable "az_subnet_3" {
  type        = string
  description = "Availability Zone C"
  default     = "ap-southeast-1c"
}
