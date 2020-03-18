module "es" {
  source  = "git::https://github.com/terraform-community-modules/tf_aws_elasticsearch.git?ref=v1.2.0"

  domain_name                    = "pciapp-domain"

  instance_count                 = 1
  instance_type                  = "m5.large.elasticsearch"
  dedicated_master_type          = "m5.large.elasticsearch"
  es_zone_awareness              = false
  ebs_volume_size                = 100

  es_version                     = "7.1"

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"   # double quotes are required here
  }

}

output "kibana_endpoint" {
  value = module.es.kibana_endpoint
}