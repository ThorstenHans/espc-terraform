# ESPC Online 2021

This repository contains my samples from the 30min talk at ESPC 2021 Online.

## Pre-Req

The state backend specified in [meta.tf](meta.tf) is not part of this repository. 

Once you've created an Storage Account with corresponding container, ensure the Service Principal (SP) used to run your Terraform project has proper access to the container (Storage Data Owner) role on the blob container scope.

### Terraform Lifecycle

Terraform projects follow a simple lifecycle as illustrated below

```bash
# init the project
terraform init

# format and validate
terraform fmt
terraform validate

# ask for execution plan (explicitly in inner-loop)
terraform plan

# apply infrastructure
terraform apply
# terraform apply -auto-approve if you want to approve execution plan automatically

# destroy infrastrcuture
terraform destroy
# terraform destroy -auto-approve if you want to approve automatically
```

