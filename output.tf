
output "id" {
  description = "The Security Group ID"
  value       = join("", aws_security_group.this.*.id)
}
output "arn" {
  description = "The Security Group ARN"
  value       = join("", aws_security_group.this.*.arn)
}

output "name" {
  description = "The Security Group Name"
  value       = join("", aws_security_group.this.*.name)
}


