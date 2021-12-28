output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "current_region" {
  value = data.aws_region.current.name
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.netology-instance.private_ip)
}

output "sudnet_id" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_subnet.netology_subnet.id)
}