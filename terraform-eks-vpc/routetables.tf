resource "aws_route_table" "eks_public" {
  vpc_id = aws_vpc.eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

}

resource "aws_route_table_association" "eks_public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.eks_public.*.id[count.index]
  route_table_id = aws_route_table.eks_public.id
}

resource "aws_default_route_table" "eks_network_private" {
  default_route_table_id = aws_vpc.eks.default_route_table_id
}

# NAT gw configuration.
resource "aws_nat_gateway" "eks_network_nat_gateway" {
  allocation_id  = aws_eip.eks_network_nat_gateway.id
  subnet_id      = aws_subnet.eks_public.*.id[0]

}

resource "aws_route" "nat-gateway" {
  route_table_id         = aws_default_route_table.eks_network_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eks_network_nat_gateway.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  subnet_id      = aws_subnet.eks_private.*.id[count.index]
  route_table_id = aws_default_route_table.eks_network_private.id
}
