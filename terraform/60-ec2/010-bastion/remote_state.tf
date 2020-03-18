data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/20-vpc/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/40-sg/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}

data "terraform_remote_state" "route53" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/50-route53/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}