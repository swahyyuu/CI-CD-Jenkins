output "azs_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.as_group.availability_zones
}
