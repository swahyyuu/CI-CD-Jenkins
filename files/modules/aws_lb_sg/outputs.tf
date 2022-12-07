output "sg_lb" {
  description = "ID of sg for load balancer"
  value       = aws_security_group.sg_lb.id
}

output "sg_ec2" {
  description = "ID of sg for ec2 instance"
  value       = aws_security_group.sg_ec2.id
}

output "elb_id" {
  description = "ID of Classic Load Balancer"
  value       = aws_elb.classic_lb.id
}
