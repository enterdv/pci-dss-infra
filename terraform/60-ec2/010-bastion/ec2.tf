variable "hostname" {
  default = "bastion"
}

data "aws_iam_instance_profile" "bastion" {
  name = "bastion-ec2-instance-role"
}

module "ec2_instance" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v2.12.0"

  name                 = "${var.environment}-bastion"
  instance_type        = "t3a.small"
  ami                  = data.aws_ami.base.id
  subnet_id            = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  key_name             = "bastion-key"
  user_data            = data.template_cloudinit_config.config.rendered
  iam_instance_profile = data.aws_iam_instance_profile.bastion.name

  associate_public_ip_address = "true"

  vpc_security_group_ids = [
    data.terraform_remote_state.sg.outputs.ssh_all,
    module.ssh_bastion_sg.this_security_group_id,
  ]

  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = "30"
      delete_on_termination = "true"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Aliases     = "bastion"
  }
}

output "bastion_public_ip" {
  value = module.ec2_instance.public_ip
}

output "bastion_private_ip" {
  value = module.ec2_instance.private_ip
}