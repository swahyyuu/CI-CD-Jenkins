output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "subnet_id_1" {
  description = "Subnet ID of AZ A"
  value       = aws_subnet.subnet_1.id
}

output "subnet_id_2" {
  description = "Subnet ID of AZ B"
  value       = aws_subnet.subnet_2.id
}

output "subnet_id_3" {
  description = "Subnet ID of AZ C"
  value       = aws_subnet.subnet_3.id
}
