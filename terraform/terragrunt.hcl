remote_state {
  backend = "s3"

  config = {
    bucket  = "pciapp-tf-state-prod"
    key     = "prod/${path_relative_to_include()}/terragrunt.tfstate"
    region  = "eu-west-1"
    encrypt = true
    dynamodb_table = "terraform_lock"
  }
}

terraform {
  extra_arguments "common" {
    commands = "${get_terraform_commands_that_need_vars()}"

    optional_var_files = [
      "${get_terragrunt_dir()}/${find_in_parent_folders("common.tfvars")}",
    ]
  }
}
