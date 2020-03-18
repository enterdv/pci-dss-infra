name = "Production"

cidr = "99.1.0.0/16"

azs  = ["eu-west-1a", "eu-west-1b"]

public_subnets  = ["99.1.0.0/24",  "99.1.1.0/24",    # DMZ
]

private_subnets = ["99.1.100.0/24", "99.1.101.0/24", # Private
]

database_subnets = ["99.1.200.0/24", "99.1.201.0/24"
]

# RDS Subnet
create_database_subnet_group = true

enable_nat_gateway = true
single_nat_gateway = true
one_nat_gateway_per_az = false

enable_vpn_gateway = false

enable_s3_endpoint = false
enable_dynamodb_endpoint = false

enable_dns_hostnames = true
enable_dhcp_options = false

map_public_ip_on_launch = false

tags = {
  Terraform = "true"
  Environment = "prod"
}