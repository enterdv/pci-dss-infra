data "template_file" "config" {
  template = file("${path.module}/init.tpl")

  vars = {
    hostname = var.hostname
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.config.rendered
  }
}

