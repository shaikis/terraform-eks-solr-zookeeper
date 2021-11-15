## create EKS cluster
## attaching required EKS policies
##

resource "aws_eks_cluster" "eks_cluster" {

  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_iam.arn
  version  = var.eks_version
  # enabled_cluster_log_types = ["api", "audit", "scheduler", "controllerManager"]

  vpc_config {
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
    subnet_ids         = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
}