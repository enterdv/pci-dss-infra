variable "hostname" {
  default = "app"
}

data "aws_iam_instance_profile" "CloudWatchAgentServerRole" {
  name = "CloudWatchAgentServerRole"
}

module "ec2_instance" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v2.12.0"

  name          = "${var.environment}-app"
  instance_type = "t3a.small"
  ami           = data.aws_ami.base.id
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  key_name      = "bastion-key"
  user_data     = data.template_cloudinit_config.config.rendered

  associate_public_ip_address = "true"

  vpc_security_group_ids = [
    data.terraform_remote_state.sg.outputs.ssh_main,
    module.this_sg.this_security_group_id,
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
    Aliases     = "app"
  }
}

output "app_private_ip" {
  value = module.ec2_instance.private_ip
}