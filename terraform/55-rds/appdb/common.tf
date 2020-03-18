provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

# variables
variable "region" {}
variable "domain" {}
variable "environment" {}
variable "env_id" {}

variable "remote_state_prefix" {
  description = "Remote state folder"
}

variable "remote_state_bucket" {
  description = "Remote state bucket"
}

variable "remote_state_bucket_region" {
  description = "Remote state bucket region"
}

