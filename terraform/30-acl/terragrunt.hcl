terraform {
  source = "./network-acl"

  after_hook "copy_common_params" {
    commands = ["init-from-module"]
    execute  = ["cp", "${find_in_parent_folders("common.tf")}", "."]
  }
}

include {
  path = "${find_in_parent_folders()}"
}
