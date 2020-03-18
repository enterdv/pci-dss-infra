module "http_any_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/http-80?ref=v3.2.0"

  name        = "${var.environment}-http-any"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform = "true"
  }
}

output "http_any" {
  value = module.http_any_sg.this_security_group_id
}