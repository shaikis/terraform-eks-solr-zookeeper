variable "vpc_cidr_block" {
    type = string
    description = "vpc cidr block"
}

variable "eks_cluster_name" {
    type = string
    description = "eks_cluster_name"
}

variable "region" {
    type = string
    description = "eks cluster region"
}

variable "aws_profile" {
  default = "eks"
  description = "configure AWS CLI profile"
}
variable "public_subnet_cidrs" {
    type = list
    description = "list of public cidrs"
}

variable "private_subnet_cidrs" {
    type = list
    description = "list of private subnet cidrs"
}

variable "ssh_key_pair" {
   default = [{key_pair_name=""}]
   type = list(object({key_pair_name=string}))
   description = "Enter SSH keypair name that already exist in the account"

}

variable "eks_version" {
    default = null
    type = string
    description = "eks version by default latest version"
}

variable "vpc_name" {
    type = string
    description = "vpc name details"
}

#### Eks cluster related parameters 

variable "eks_cluster_iam_name" {
    type = string
    description = "eks cluster iam roles"
}

variable "eks_cluster_sg_egress_rules" {
    type = list(object({protocol=string, from_port=string, to_port=string, cidr_blocks=string}))
    description = "A list of egress NACL rules"
}
variable "eks_cluster_sg_name" {
    type = string
}



