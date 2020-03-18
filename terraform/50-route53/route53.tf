resource "aws_route53_zone" "this" {
  name = var.environment

  vpc {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  }
}