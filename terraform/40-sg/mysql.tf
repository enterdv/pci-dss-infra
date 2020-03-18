module "mysql_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/mysql?ref=v3.2.0"

  name        = "${var.environment}-mysql"
  description = "Security group for RDS MySQL"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = [
    "${data.terraform_remote_state.app.outputs.app_private_ip[0]}/32",
  ]

  tags = {
    Terraform = "true"
  }
}

output "mysql" {
  value = module.mysql_sg.this_security_group_id
}