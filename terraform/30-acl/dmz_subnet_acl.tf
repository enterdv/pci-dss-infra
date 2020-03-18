module "dmz_subnet_acl" {
  source = "./network-acl"

  subnet_ids = [data.terraform_remote_state.vpc.outputs.public_subnets[0], data.terraform_remote_state.vpc.outputs.public_subnets[1]]
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id

  inbound_acl_rules = [
    "100", "allow", 1024, 65535, "tcp", "0.0.0.0/0", "Allows inbound responses from any address",

    "110", "allow", 80,   80,    "tcp", "0.0.0.0/0", "Allows inbound HTTP traffic from any address",
    "111", "allow", 443,  443,   "tcp", "0.0.0.0/0", "Allows inbound HTTPS traffic from any address",
    "112", "allow", 22,   22,    "tcp", "0.0.0.0/0", "Allows inbound SSH traffic from any address",

  ]

  outbound_acl_rules = [
    "100", "allow", 1024, 65535, "tcp", "0.0.0.0/0", "Allows outbound HTTP responses to any address",

    "110", "allow", 80,    80,     "tcp", "0.0.0.0/0", "Allows outbound HTTP traffic to any address",
    "111", "allow", 443,   443,    "tcp", "0.0.0.0/0", "Allows outbound HTTPS traffic to any address",
  ]

  tags = {
    Terraform = "true"
    Name = "${var.environment}-dmz"
  }
}