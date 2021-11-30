# terraform-eks-solr-zookeeper

This module useful to create Eks cluster and node groups using terraform . 

Actual plan will be installing  zookeeper and solr on EKS nodes.

#### How to execute it . 
cd terraform-eks-solr-zookeeper
./run_terraform.sh  # this will do terraform init , plan
./run_apply.sh      # this will do terraform apply
![Arch](https://github.com/shaikis/terraform-eks-solr-zookeeper/blob/main/snapshots/Apache_zookeeper_solr.png)
