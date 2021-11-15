    output "cluster_name" {
        value = aws_eks_cluster.eks_cluster.name # module.eks_cluster.cluster_name
        }
    output "cluster_endpoint" {
        value = aws_eks_cluster.eks_cluster.endpoint # module.eks_cluster.cluster_endpoint
        }
    output "cluster_ca_data" {
        value = aws_eks_cluster.eks_cluster.certificate_authority[0].data # module.eks_cluster.cluster_ca_data
        }