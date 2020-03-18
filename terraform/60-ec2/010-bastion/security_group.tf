module "ssh_bastion_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/ssh?ref=v3.2.0"

  name        = "${var.environment}-ssh-from-bastion"
  description = "Security group for SSH from bastion"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["${module.ec2_instance.private_ip[0]}/32"]
}

output "ssh_bastion_sg" {
  value = module.ssh_bastion_sg.this_security_group_id
}