## Terraform

```bash
cd dev
terraform init
```
```bash
cd dev
terraform plan --var-file="dev.tfvars" -out="terraform.tfplan"
```

```bash
cd dev
terraform apply "terraform.tfplan"
```