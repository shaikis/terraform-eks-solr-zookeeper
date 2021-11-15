variable "vpc_cidr_block" {}
variable "private_subnets" {
    type = list
}
variable "public_subnets" {
    type = list
}

variable "eks_cluster_name" {}
variable "vpc_name" {
    type = string
    description = "vpc_name details"
}

variable "vpc_tags" {
    type = map(string)
    default = {}
}

variable "private_subnet_tags" {
    type = map(string)
    default = {}
}

variable "public_subnet_tags" {
    type = map(string)
    default = {}
}