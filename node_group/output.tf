output "launch_template_name" {
  value = aws_launch_template.nodegroup_lt.name_prefix
}

# Node group output variables
output "node_group_name" {
  value = aws_eks_node_group.worker-node-group.node_group_name
}
output "worker_desired_size" {
  value = var.worker_desired_size
}
output "worker_max_size" {
  value = var.worker_max_size
}
output "worker_min_size" {
  value = var.worker_min_size
}