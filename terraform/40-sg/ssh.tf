module "ssh_all_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/ssh?ref=v3.2.0"

  name        = "${var.environment}-ssh-from-all"
  description = "Security group for SSH access from Internet"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform = "true"
  }
}

output "ssh_all" {
  value = module.ssh_all_sg.this_security_group_id
}

module "ssh_main_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/ssh?ref=v3.2.0"

  name        = "${var.environment}-ssh-from-bastion"
  description = "Security group for SSH access from Bastion"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["${data.terraform_remote_state.bastion.outputs.bastion_private_ip[0]}/32"]

  tags = {
    Terraform = "true"
  }
}

output "ssh_main" {
  value = module.ssh_main_sg.this_security_group_id
}