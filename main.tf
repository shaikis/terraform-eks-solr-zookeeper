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

  ami_type           = "CUSTOM"
  desired_size       = 1
  min_size           = 1
  max_size           = 1

  #instance_types     = ["t3a.large","t3a.large"]
  capacity_type      = "SPOT"
  
  #ec2_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrzxQpN12frrUi+PtX4CZnyd+TJTJJjACTqhpM6cl4jiW+NX+ojkCGPI4o1mtR925UPmQebPYSOf1Ldk+RbRMFn7uA9zKjIe+z9OA7u9zAlZoO/+mJ7ug/w+jdUWPmWW0/lvVJAVWlYljtzC4Mp/Pf4LClxyXroKS/uB2IN2J1M3HLAOBGy3s2ZY6/32adKPc8iMT1IORxSvNQr4brIl+U3xJth5BrJzIb0VUsdZoU5pF/nswUOPAFUsYcpLEh6DMjaerJ70blF8sWOSxFU6mBLlWKaojsz60SJSOhaCvcmWCsnYFohTkvKd6+pJQiX1El8FkbpH3l++cshvqienDl root@master.example.com"

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
  ami_type          = "CUSTOM"
  desired_size      = 1
  min_size          = 1
  max_size          = 1

  #instance_types    = ["t3a.large","t3a.large"]
  capacity_type     = "SPOT"
  
  #ec2_ssh_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrzxQpN12frrUi+PtX4CZnyd+TJTJJjACTqhpM6cl4jiW+NX+ojkCGPI4o1mtR925UPmQebPYSOf1Ldk+RbRMFn7uA9zKjIe+z9OA7u9zAlZoO/+mJ7ug/w+jdUWPmWW0/lvVJAVWlYljtzC4Mp/Pf4LClxyXroKS/uB2IN2J1M3HLAOBGy3s2ZY6/32adKPc8iMT1IORxSvNQr4brIl+U3xJth5BrJzIb0VUsdZoU5pF/nswUOPAFUsYcpLEh6DMjaerJ70blF8sWOSxFU6mBLlWKaojsz60SJSOhaCvcmWCsnYFohTkvKd6+pJQiX1El8FkbpH3l++cshvqienDl root@master.example.com"

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