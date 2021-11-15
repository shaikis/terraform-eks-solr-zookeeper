resource "aws_vpc" "eks" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
 
  tags = merge(
    var.vpc_tags
  )
}









