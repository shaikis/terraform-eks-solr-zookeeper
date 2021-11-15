 rm -rf .terraform
terraform init -var-file=./env/dev/dev.tfvars
terraform plan -var-file=./env/dev/dev.tfvars
