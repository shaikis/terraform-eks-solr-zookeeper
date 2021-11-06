module "eks_cluster" {
    source               = "git@github.com:shaikis/terraform-aws-eks.git"
    eks_cluster_name     = "eks-test"
    vpc_id               = "vpc-4c12ec2b"
    subnet_ids           = ["subnet-b43efbfd", "subnet-22b4b17a"]
    eks_cluster_version  = "1.21"
}

module "zookeeper-node-group" {
  source = "git@github.com:shaikis/terraform-eks-nodegroup.git"
  cluster_name       = module.eks_cluster.eks_cluster_name
  subnet_ids         = ["subnet-b43efbfd", "subnet-22b4b17a"]
  
  node_role_arn      = module.eks_cluster.eks_node_arn
  create_iam_role    = false

  ami_type           = "AL2_x86_64_GPU"
  desired_size       = 1
  min_size           = 1
  max_size           = 1

  instance_types     = ["t3a.large","t3a.large"]
  capacity_type      = "SPOT"
  
  ec2_ssh_key        = "eks-test"

  launch_template    = {
    id      = data.aws_launch_template.cluster.id
    version = data.aws_launch_template.cluster.latest_version
  }

  labels             = {
    lifecycle = "OnDemand"
  }

  tags               = {
    "kubernetes.io/cluster/eks" = "owned"
     Environment                 = "test"
  }

  depends_on         = [data.aws_launch_template.cluster]
}

module "solr-node-group" {
  source = "git@github.com:shaikis/terraform-eks-nodegroup.git"
  cluster_name      = module.eks_cluster.eks_cluster_name
  subnet_ids        = ["subnet-b43efbfd", "subnet-22b4b17a"]

  node_role_arn     = module.eks_cluster.eks_node_arn
  create_iam_role   = false
  ami_type          = "AL2_x86_64_GPU"
  desired_size      = 1
  min_size          = 1
  max_size          = 1

  instance_types    = ["t3a.large","t3a.large"]
  capacity_type     = "SPOT"
  
   ec2_ssh_key      = "eks-test"

  launch_template   = {
    id      = data.aws_launch_template.cluster.id
    version = data.aws_launch_template.cluster.latest_version
  }

  labels            = {
    lifecycle = "OnDemand"
  }

  tags              = {
    "kubernetes.io/cluster/eks" = "owned"
     Environment                 = "test"
  }
  force_update_version = true
  depends_on = [data.aws_launch_template.cluster]
}