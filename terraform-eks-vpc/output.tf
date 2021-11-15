output "public_sub_net_id" {
  value       = "${join(",", aws_subnet.eks_public.*.id)}"

}

output "private_sub_net_id" {
  value       = "${join(",", aws_subnet.eks_private.*.id)}"
}

output "vpc_id_value" {
  value       = aws_vpc.eks.id
}