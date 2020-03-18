resource "aws_eip" "this" {
  vpc = true
  tags = {
    Name      = "${var.environment}-public-nginx"
    Terraform = "true"
  }
}

resource "aws_eip_association" "this" {
  instance_id   = module.ec2_instance.id[0]
  allocation_id = aws_eip.this.id
}