module "https_any_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/https-443?ref=v3.2.0"

  name        = "${var.environment}-https"
  description = "Security group for web-server with HTTPS ports open within VPC"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform = "true"
  }
}

output "https_any" {
  value = module.https_any_sg.this_security_group_id
}