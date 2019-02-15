set RESOURCE_GROUP_NAME=tfstate_resources
set STORAGE_ACCOUNT_NAME=tfstate%RANDOM%
set CONTAINER_NAME=tfstate
set AZURE_REGION=westeurope
set AZURE_SUBSCRIPTION=YOUR_AZURE_SUBSCRIPTION_ID

REM Create resource group
az group create --name %RESOURCE_GROUP_NAME% --location %AZURE_REGION% --subscription %AZURE_SUBSCRIPTION%

REM Create storage account
az storage account create --resource-group %RESOURCE_GROUP_NAME% --name %STORAGE_ACCOUNT_NAME% --location %AZURE_REGION% --subscription %AZURE_SUBSCRIPTION% --sku Standard_LRS --encryption-services blob

REM Get storage account key
set ACCOUNT_KEY=(`az storage account keys list --resource-group %RESOURCE_GROUP_NAME% --account-name %STORAGE_ACCOUNT_NAME% --subscription %AZURE_SUBSCRIPTION% --query [0].value -o tsv`)

REM Create blob container
az storage container create --name %CONTAINER_NAME% --account-name %STORAGE_ACCOUNT_NAME% --account-key %ACCOUNT_KEY%

echo storage_account_name: %STORAGE_ACCOUNT_NAME%
echo container_name: %CONTAINER_NAME%
echo access_key: %ACCOUNT_KEY%
