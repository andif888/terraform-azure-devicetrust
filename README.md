# deviceTRUST environment in Azure using Terraform
this repo provisions test or multiple training environments for deviceTRUST (https://devicetrust.de).

To learn about deviceTRUST, please check out the [Getting Started](https://docs.devicetrust.com/docs/getting-started/)

It spins up the following VMs:
- DC - Windows Domain Controller
- RDSH - Windows Remote Desktop Session Host
- CLIENT - Windows 10 Client, which has joined the AD Domain
- BYOD - Windows 10 Client without domain join

## Requirements
You need a Azure Subscription. If you have for example a Windows Azure MSDN Subscription you can easily use this. Running it for some hours cost only a few cents.  
You need Terraform installed. To install Terraform please checkout https://www.terraform.io/downloads.html  

You need a azure storage account, which is used to save the `terraform.tfstate` offsite in Azure.
You can use [backend_az_storage.sh](backend_az_storage.sh) or [backend_az_storage.cmd](backend_az_storage.cmd) on Windows as starting point to create an Azure storage account using Azure CLI. Make sure you have [Azure-CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed. For further information see https://docs.microsoft.com/en-us/azure/terraform/terraform-backend

You also need a service principal in Azure AD which has a contributor permission to your Azure Subscription.  
For that, you need to register a new App in Azure AD.  
Checkout [creating a Service Principal in the Azure Portal](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html) or the short instructions in [terraform.tfvars.sample](terraform.tfvars.sample).

## Using this repo

Clone the repo using
```bash
git clone https://github.com/andif888/terraform-azure-devicetrust
```

Rename or copy the [backend.tfvars.sample](backend.tfvars.sample) to `backend.tfvars` and fill in your azure storage account details.

When done run terraform init to initialize your backend.
```bash
terraform init -backend-config="backend.tfvars"
```
Rename or copy the [terraform.tfvars.sample](terraform.tfvars.sample) to `terraform.tfvars` and fill in your azure details and service principal details and also change the values to your needs.


to run terraform planing use:
```bash
terraform plan
```

to actually provision VMs in Azure run:
```bash
terraform apply
```

to destroy the whole deployment run:
```bash
terraform destroy
```
