resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_network_acl_rule" "inbound" {
  count = length(var.subnet_ids) > 0 ? length(var.inbound_acl_rules) / 7 : 0

  network_acl_id = aws_network_acl.this.id

  egress      = false
  rule_number = element(var.inbound_acl_rules, count.index * 7 + 0)
  rule_action = element(var.inbound_acl_rules, count.index * 7 + 1)
  from_port   = element(var.inbound_acl_rules, count.index * 7 + 2)
  to_port     = element(var.inbound_acl_rules, count.index * 7 + 3)
  protocol    = element(var.inbound_acl_rules, count.index * 7 + 4)
  cidr_block  = element(var.inbound_acl_rules, count.index * 7 + 5)
}

resource "aws_network_acl_rule" "outbound" {
  count = length(var.subnet_ids) > 0 ? length(var.outbound_acl_rules) / 7 : 0

  network_acl_id = aws_network_acl.this.id

  egress      = true
  rule_number = element(var.outbound_acl_rules, count.index * 7 + 0)
  rule_action = element(var.outbound_acl_rules, count.index * 7 + 1)
  from_port   = element(var.outbound_acl_rules, count.index * 7 + 2)
  to_port     = element(var.outbound_acl_rules, count.index * 7 + 3)
  protocol    = element(var.outbound_acl_rules, count.index * 7 + 4)
  cidr_block  = element(var.outbound_acl_rules, count.index * 7 + 5)
}

