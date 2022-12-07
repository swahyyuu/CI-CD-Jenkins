output "vpc_id" {
  description = "value of VPC Id"
  value       = module.aws_terra_vpc.vpc_id
}

output "account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "arn" {
  description = "AWS Account ARN"
  value       = data.aws_caller_identity.current.arn
}

output "user_id" {
  description = "AWS User Account ID"
  value       = data.aws_caller_identity.current.user_id
}

output "azs_name" {
  description = "Auto Scaling Group Name"
  value       = module.aws_terra_instance.azs_name
}
