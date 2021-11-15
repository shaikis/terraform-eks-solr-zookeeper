variable "eks_cluster_iam_name" {}
variable "sg_egress_rules" {
    type = list(object({protocol=string, from_port=string, to_port=string, cidr_blocks=string}))
    description = "A list of eks cluster sg egress  rules"
}

variable "eks_cluster_sg_name" {}
variable "subnet_ids" {
    type = list(string)
}

variable "vpc_id" {}
variable "eks_cluster_name" {
    type = string
}
variable "eks_version" {
    type = string
    default="1.21"
}