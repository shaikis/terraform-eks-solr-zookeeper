variable "key_pair_name" {
    default = "eks-test"  
}
variable "create_key_pair" {
    type = bool
    default = true      
    
}
variable "public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrzxQpN12frrUi+PtX4CZnyd+TJTJJjACTqhpM6cl4jiW+NX+ojkCGPI4o1mtR925UPmQebPYSOf1Ldk+RbRMFn7uA9zKjIe+z9OA7u9zAlZoO/+mJ7ug/w+jdUWPmWW0/lvVJAVWlYljtzC4Mp/Pf4LClxyXroKS/uB2IN2J1M3HLAOBGy3s2ZY6/32adKPc8iMT1IORxSvNQr4brIl+U3xJth5BrJzIb0VUsdZoU5pF/nswUOPAFUsYcpLEh6DMjaerJ70blF8sWOSxFU6mBLlWKaojsz60SJSOhaCvcmWCsnYFohTkvKd6+pJQiX1El8FkbpH3l++cshvqienDl root@master.example.com"
  
}

variable "key_name_prefix" {
    default = ""  
}

variable "tags" {
    type = map(string)
    default = {}  
}