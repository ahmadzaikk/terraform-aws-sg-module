locals {
  security_group_enabled = var.security_group_enabled
  name = var.name
  rules = var.rules != null ? {
    for indx, rule in flatten(var.rules) :
    format("%v-%v-%v-%v-%s",
      rule.type,
      rule.protocol,
      rule.from_port,
      rule.to_port,
      try(rule["description"], null) == null ? md5(format("Managed by Terraform #%d", indx)) : md5(rule.description)
    ) => rule
  } : {}
}

resource "aws_security_group" "this" {
  count = local.security_group_enabled ? 1 : 0 
  name = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "this" {
  for_each = local.rules
  security_group_id = aws_security_group.this.*.id[0]
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  description       = lookup(each.value, "description", "Managed by Terraform")
  cidr_blocks      = try(length(lookup(each.value, "cidr_blocks", [])), 0) > 0 ? each.value["cidr_blocks"] : null
  


}