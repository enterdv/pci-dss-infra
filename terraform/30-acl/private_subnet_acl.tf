module "private_subnet_acl" {
  source = "./network-acl"

  subnet_ids = [data.terraform_remote_state.vpc.outputs.private_subnets[0], data.terraform_remote_state.vpc.outputs.private_subnets[1]]
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id

  inbound_acl_rules = [
    "100", "allow", 1024, 65535, "tcp", "0.0.0.0/0", "Allows inbound responses from the Internet",

    "110", "allow", 22,   22,    "tcp", "${data.terraform_remote_state.bastion.outputs.bastion_private_ip[0]}/32", "Allows inbound SSH traffic from bastion",
  ]

  outbound_acl_rules = [
    "100", "allow", 1024, 65535, "tcp", "${data.terraform_remote_state.bastion.outputs.bastion_private_ip[0]}/32", "Allows outbound responses for bastion",

    "110", "allow", 80,   80,    "tcp", "0.0.0.0/0", "Allows outbound HTTP traffic to any address",
    "111", "allow", 443,  443,   "tcp", "0.0.0.0/0", "Allows outbound HTTPS traffic to any address",

  ]

  tags = {
    Terraform = "true"
    Name = "${var.environment}-private"
  }
}
