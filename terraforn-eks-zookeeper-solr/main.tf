# declare provider
# Declare backend.
provider "aws" {
  region = "${var.region}"
  profile = "${var.aws_profile}"
}

terraform {
  backend "s3" {
    bucket = "ismail-tio-test"
    key    = "vpc/eks_cluster/terraform.tfstate"
    region = "eu-west-1"
  }
}

# execute this fist
module "eks_vpc" {
    source                = "../terraform-eks-vpc"
    vpc_name              = var.vpc_name
    vpc_cidr_block        = var.vpc_cidr_block
    private_subnets       = var.private_subnet_cidrs
    public_subnets        = var.public_subnet_cidrs
    eks_cluster_name      = var.eks_cluster_name
    # enable below tags after cluster build.
    vpc_tags = {
       "Name" = "eks_vpc",
       "kubernetes.io/cluster/${var.eks_cluster_name}"="shared"
    }
  #
   public_subnet_tags = { 
       "Name" = "eks_public-subnet",
       "kubernetes.io/role/elb"         = "1",
       "kubernetes.io/role/alb-ingress" = "1",
       "kubernetes.io/cluster/${var.eks_cluster_name}"="shared",
       "subnet-type"             = "public"
       }
  #
   private_subnet_tags = {
       "Name"="eks_private_subnet",
       "kubernetes.io/cluster/${var.eks_cluster_name}"="shared",
       "kubernetes.io/role/alb-ingress"  = "1"
       "subnet-type"             = "private"
       "kubernetes.io/role/internal-elb"="1"
      }
  
}


# execute this next 
module "eks_cluster" {
  source                    = "../terraform-eks-cluster"
  vpc_id                    = module.eks_vpc.vpc_id_value 
  eks_cluster_name          = var.eks_cluster_name
  eks_version               = var.eks_version
  eks_cluster_iam_name      = var.eks_cluster_iam_name
  sg_egress_rules           = var.eks_cluster_sg_egress_rules
  eks_cluster_sg_name       = var.eks_cluster_sg_name
  subnet_ids                = [ "${element(split(",", module.eks_vpc.public_sub_net_id), 0)}","${element(split(",", module.eks_vpc.public_sub_net_id), 1)}","${element(split(",", module.eks_vpc.private_sub_net_id), 0)}", "${element(split(",", module.eks_vpc.private_sub_net_id), 1)}"] 
  depends_on                = [module.eks_vpc]
}
# Add tags in vpc module before adding node groups/nodes.

module "key_pair" {
  source = "../key_pair"

  key_name   = "eks_worker_node_key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrzxQpN12frrUi+PtX4CZnyd+TJTJJjACTqhpM6cl4jiW+NX+ojkCGPI4o1mtR925UPmQebPYSOf1Ldk+RbRMFn7uA9zKjIe+z9OA7u9zAlZoO/+mJ7ug/w+jdUWPmWW0/lvVJAVWlYljtzC4Mp/Pf4LClxyXroKS/uB2IN2J1M3HLAOBGy3s2ZY6/32adKPc8iMT1IORxSvNQr4brIl+U3xJth5BrJzIb0VUsdZoU5pF/nswUOPAFUsYcpLEh6DMjaerJ70blF8sWOSxFU6mBLlWKaojsz60SJSOhaCvcmWCsnYFohTkvKd6+pJQiX1El8FkbpH3l++cshvqienDl root@master.example.com"

}

module "eks_zookeeper_nodegroup" {
  source                         = "../node_group"
  cluster_name                   = module.eks_cluster.cluster_name
  cluster_endpoint               = module.eks_cluster.cluster_endpoint
  cluster_ca_data                = module.eks_cluster.cluster_ca_data
  eks_version                    = var.eks_version
  cluster_autoscaler             = false
  name                           = var.eks_cluster_name
  instance_size                  = "t2.xlarge"
  private_subnet_ids             = [ "${element(split(",", module.eks_vpc.private_sub_net_id), 0)}", "${element(split(",", module.eks_vpc.private_sub_net_id), 1)}"]
  # node group worker node size. 
  worker_desired_size            = 2 # default 5
  worker_max_size                = 2 # default 3
  worker_min_size                = 2 # default 3
  key_name                       = module.key_pair.key_pair_key_name

}