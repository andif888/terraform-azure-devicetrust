# deviceTRUST environment in Azure using Terraform
this repo provisions test or multiple training environments for deviceTRUST (https://devicetrust.de).

It spins up the following VMs:
- DC - Windows Domain Controller
- RDSH - Windows Remote Desktop Session Host
- CLIENT - Windows 10 Client, which has joined the AD Domain
- BYOD - Windows 10 Client without domain join

## Requirements 
You need a Azure Subscription. If you have for example a Windows Azure MSDN Subscription you can easily use this. Running it for some hours cost only a few cents.  
You need Terraform installed. To install Terraform please checkout https://www.terraform.io/downloads.html  

You need a azure storage account, which is used to save the `terraform.tfstate` offsite in Azure. 
You can use [backend_az_storage.sh](backend_az_storage.sh) as starting point to create an Azure storage account using Azure CLI. For further information see https://docs.microsoft.com/en-us/azure/terraform/terraform-backend

Rename the [backend.tfvars.sample](backend.tfvars.sample) to `backend.tfvars` and fill in your azure storage account details. 

When done run terraform init to initialize your backend.
```
terraform init -backend-config="backend.tfvars"
```

## Using this repo
Clone the repo using 
```
git clone https://github.com/andif888/terraform-azure-devicetrust
```

after cloning the repo, change to the local directory using
```
cd terraform-azure-devicetrust
```
Rename the [terraform.tfvars.sample](terraform.tfvars.sample) to `terraform.tfvars` and fill in your azure details and also change the values to your needs.

to run terraform planing use:
```
terraform plan
```

to actually provision VMs in Azure run:
```
terraform apply
```

to destroy the whole deployment run:
```
terraform destroy
```

