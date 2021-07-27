variable "vpc_id" {
  type        = string
  description = "The VPC ID where Security Group will be created."
}

variable "security_group_enabled" {
  type        = bool
  default     = true
  description = "Whether to create Security Group."
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "The Security Group description."
}

variable "rules" {
  type        = list(any)
  default     = null
  description = <<-EOT
    A list of maps of Security Group rules. 
    The values of map is fully complated with `aws_security_group_rule` resource. 
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
  EOT
}

variable "name"{
  type = string
  default = ""
}

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}