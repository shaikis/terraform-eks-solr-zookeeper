## internet gateway
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks.id

  tags ={
    Name = "eks-internet-gateway"
  }
}

#resource "aws_nat_gateway" "nat_gw" {
#  count = 1
#  
#  allocation_id = aws_eip.nat.id
#  subnet_id     = aws_subnet.eks_public.*.id[count.index]  #public subnet 
#  depends_on = [aws_internet_gateway.eks_igw]
#
#  tags = {
#    Name = "gw NAT"
#  }
#}

# NAT gateway
resource "aws_eip" "eks_network_nat_gateway" {
  vpc        = true
  depends_on = [aws_internet_gateway.eks_igw]

  tags = {
    Name = "eks-nat-gateway"
  }
}