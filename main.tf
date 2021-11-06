module "eks_cluster" {
    source               = "git@github.com:shaikis/terraform-aws-eks.git"
    eks_cluster_name     = "eks-test"
    vpc_id               = "vpc-4c12ec2b"
    subnet_ids           = ["subnet-b43efbfd", "subnet-22b4b17a"]
    eks_cluster_version  = "1.21"
}

module "eks-node-group" {
  source = "git@github.com:shaikis/terraform-eks-nodegroup.git"
  cluster_name     = module.eks_cluster.eks_cluster_endpoint
  subnet_ids       = ["subnet-b43efbfd", "subnet-22b4b17a"]

  desired_size = 1
  min_size     = 1
  max_size     = 1

  launch_template = {
    id      = data.aws_launch_template.cluster.id
    version = data.aws_launch_template.cluster.latest_version
  }

  labels = {
    lifecycle = "OnDemand"
  }

  tags = {
    "kubernetes.io/cluster/eks" = "owned"
     Environment                 = "test"
  }

  depends_on = [data.aws_launch_template.cluster]
}