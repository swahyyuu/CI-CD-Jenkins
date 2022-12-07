variable "vpc_id" {
  type        = string
  description = "VPC ID"
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

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports for SG Load Balancer"
  default     = [22, 80, 443]
}

variable "any_port" {
  type        = list(string)
  description = "Receive request from any ports"
  default     = ["0.0.0.0/0"]
}
