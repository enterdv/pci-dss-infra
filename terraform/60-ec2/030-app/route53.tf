resource "aws_route53_record" "this" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = "app"
  type    = "A"
  ttl     = "300"
  records = module.ec2_instance.private_ip
}