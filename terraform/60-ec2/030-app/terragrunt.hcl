terraform {
  source = "./null"

  after_hook "copy_common_params" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("common.tf")}", "."]
  }
  after_hook "copy_remote_state" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("ami.tf")}", "."]
  }
}

include {
  path = "${find_in_parent_folders()}"
}