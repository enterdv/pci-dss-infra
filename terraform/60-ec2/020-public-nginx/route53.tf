resource "aws_route53_record" "internal" {
  zone_id = data.terraform_remote_state.route53.outputs.zone_id
  name    = "public-nginx"
  type    = "A"
  ttl     = "300"
  records = module.ec2_instance.private_ip
}