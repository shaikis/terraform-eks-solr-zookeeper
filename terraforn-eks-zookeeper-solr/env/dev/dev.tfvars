# Vpc parameters
vpc_name             = "eks-dev-vpc"
region               = "eu-west-1"
vpc_cidr_block       = "10.15.0.0/19"
private_subnet_cidrs = ["10.15.12.0/22", "10.15.16.0/22", "10.15.20.0/22"]
public_subnet_cidrs  = ["10.15.0.0/22", "10.15.4.0/22", "10.15.8.0/22"]

# eks parameters
eks_version          = "1.21"
eks_cluster_name         = "eks-dev-cluster"

#Key pairs
ssh_key_pair = [ 
    {key_pair_name = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrzxQpN12frrUi+PtX4CZnyd+TJTJJjACTqhpM6cl4jiW+NX+ojkCGPI4o1mtR925UPmQebPYSOf1Ldk+RbRMFn7uA9zKjIe+z9OA7u9zAlZoO/+mJ7ug/w+jdUWPmWW0/lvVJAVWlYljtzC4Mp/Pf4LClxyXroKS/uB2IN2J1M3HLAOBGy3s2ZY6/32adKPc8iMT1IORxSvNQr4brIl+U3xJth5BrJzIb0VUsdZoU5pF/nswUOPAFUsYcpLEh6DMjaerJ70blF8sWOSxFU6mBLlWKaojsz60SJSOhaCvcmWCsnYFohTkvKd6+pJQiX1El8FkbpH3l++cshvqienDl root@master.example.com"}
]

# Eks cluster module related parameters
eks_cluster_iam_name = "eks-cluster-iam"

eks_cluster_sg_egress_rules = [
    {protocol="-1", from_port=0, to_port=0, cidr_blocks="0.0.0.0/0"}
]

eks_cluster_sg_name = "dev-eks-cluster-sg"


# tags will play major role in EKS cluster don't remove it . 
 # vpc_tags = "${
 #   map(
 #    "Name", "eks_public-subnet",
 #    "kubernetes.io/cluster/${var.eks_cluster_name}", "shared"
 #   )
 # }"
#
 #public_subnet_tags = "${ 
 #    map(
 #    "Name", "eks_private-subnet",
 #    "kubernetes.io/cluster/${var.eks_cluster_name}", "shared",
 #    )
 #    }"
#
 #private_subnet_tags = "${ 
 #    map(
 #    "Name", "eks_private-subnet",
 #    "kubernetes.io/cluster/${var.eks_cluster_name}", "shared",
 #    "kubernetes.io/role/internal-elb", "1",
 #    )
 #    }"