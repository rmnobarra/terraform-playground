# terraform aks azure

## How uses?

1. Setup remote state 

```bash
#!/bin/bash

RESOURCE_GROUP_NAME=tfstate-aks
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

## Create resource group
az group create --name $RESOURCE_GROUP_NAME --location westus2

## Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

## Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

## Show storage account name
az storage account list -g tfstate-aks | jq '.[].name' -r
```

or
```bash
./script.sh
```

3. Setup terraform remote state in terraform file providers.tf on line number 24. Using storage account name from output above.

4. Run terraform

```bash
terraform init && terraform apply --auto-approve
```

5. Access aks cluster

```bash
resource_group_name=$(terraform output -raw resource_group_name)

az aks list \
  --resource-group $resource_group_name \
  --query "[].{\"K8s cluster name\":name}" \
  --output table

echo "$(terraform output kube_config)" > ./azurek8s

cat ./azurek8s

export KUBECONFIG=./azurek8s

kubectl get nodes
```