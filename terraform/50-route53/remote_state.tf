data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "${var.remote_state_prefix}/20-vpc/terragrunt.tfstate"
    region = var.remote_state_bucket_region
  }
}

