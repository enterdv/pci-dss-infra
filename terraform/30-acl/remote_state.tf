data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/20-vpc/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}

data "terraform_remote_state" "bastion" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/60-ec2/010-bastion/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}

data "terraform_remote_state" "app" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/60-ec2/030-app/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}