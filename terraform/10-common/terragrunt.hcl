terraform {
  source = "./null"

  after_hook "copy_common_params" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("common.tf")}", "."]
  }
  after_hook "copy_ssh_key" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("bastion.pub")}", "."]
  }
}

include {
  path = "${find_in_parent_folders()}"
}
