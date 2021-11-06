data "aws_ssm_parameter" "cluster" {
  name = "/aws/service/eks/optimized-ami/${module.eks_cluster.version}/amazon-linux-2/recommended/image_id"
}

data "aws_launch_template" "cluster" {
  name = aws_launch_template.cluster.name
  depends_on = [aws_launch_template.cluster]
}

resource "aws_launch_template" "cluster" {
  image_id               = data.aws_ssm_parameter.cluster.value
  instance_type          = "t3.medium"
  name                   = "eks-launch-template-test"
  update_default_version = true

  key_name = "eks-test"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                        = "eks-node-group-instance-name"
      "kubernetes.io/cluster/eks" = "owned"
    }
  }

  user_data = base64encode(templatefile("userdata.tpl", { CLUSTER_NAME = module.eks_cluster.eks_cluster_name, B64_CLUSTER_CA = module.eks_cluster.eks_cluster_certificate_authority_data, API_SERVER_URL = module.eks_cluster.eks_cluster_endpoint }))
}