variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
}

variable "inbound_acl_rules" {
  type = list(string)
}

variable "outbound_acl_rules" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

