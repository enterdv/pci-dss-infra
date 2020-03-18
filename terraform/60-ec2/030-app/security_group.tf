module "this_sg" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group?ref=v3.2.0"

  name        = "${var.environment}-app"
  description = "Security group for App EC2 Instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Nginx Frontend"
      cidr_blocks = "${data.terraform_remote_state.public_nginx.outputs.public_nginx_private_ip[0]}/32"
    },
  ]
}