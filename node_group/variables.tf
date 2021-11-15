# Node group variables.
variable "worker_desired_size" {
  type        = number
  default     = 3
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}
variable "worker_max_size" {
  type        = number
  default     = 5
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}

variable "worker_min_size" {
  type        = number
  default     = 3
  description = "The minimum number of instances that will be launched by this group, if not a multiple of the number of AZs in the group, may be rounded up"
}

# variable Cluster name

variable "cluster_name" {
    type = string
}

variable "cluster_endpoint" {
    type = string
}

variable "cluster_ca_data" {
    type = string
}

variable "eks_version" {
    default = "1.21"
}

variable "cluster_autoscaler" {
    default = true
}

#

variable "name" {
    type = string
}

variable "private_subnet_ids" {
    type = list
    }

variable "tags" {
    type = map(string)
    default = {}
}