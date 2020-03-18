# Variables common to both master and replica

locals {
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.medium"
  allocated_storage = 5
  port              = "3306"
}

module "master" {
  source = "github.com/terraform-aws-modules/terraform-aws-rds?ref=v2.5.0"

  identifier = "${var.environment}-appdb"

  engine            = local.engine
  engine_version    = local.engine_version
  instance_class    = local.instance_class
  allocated_storage = local.allocated_storage

  name     = "appdb"
  username = "appdb"
  password = "strong_password"
  port     = "3306"

  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.mysql]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }

  # DB subnet group
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.database_subnets[0],
    data.terraform_remote_state.vpc.outputs.database_subnets[1],
  ]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = local.engine_version

  # Snapshot name upon DB deletion
  final_snapshot_identifier = var.environment

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "log_bin_trust_function_creators"
      value = true
    },
  ]
}