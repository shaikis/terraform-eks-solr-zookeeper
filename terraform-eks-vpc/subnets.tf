## EKS public subnets

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

resource "aws_subnet" "eks_public" {
  count = length(var.public_subnets)

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.public_subnets[count.index]
  vpc_id            = aws_vpc.eks.id

  tags = merge(
    var.public_subnet_tags
  )
}

resource "aws_subnet" "eks_private" {
  count = length(var.private_subnets)

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.private_subnets[count.index]
  vpc_id            = aws_vpc.eks.id

  tags = merge(
    var.private_subnet_tags
  )
}