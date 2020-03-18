terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.18.0"

  after_hook "copy_global_params" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("common.tf")}", "."]
  }

  extra_arguments "module_vars" {
    commands = "${get_terraform_commands_that_need_vars()}"

    optional_var_files = [
      "${get_terragrunt_dir()}/vpc.tfvars",
    ]
  }
}

include {
  path = "${find_in_parent_folders()}"
}