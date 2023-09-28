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

3. Setup terraform remote state in terraform file providers.tf on line number 24. Using storage account name from output above or just execute:

```bash
./script.sh
```

4. Run terraform

```bash
terraform init && terraform apply --auto-approve
```

5. Access aks cluster

```bash
resource_group_name=$(terraform output -raw resource_group_name)
kubernetes_cluster_name=$(terraform output -raw kubernetes_cluster_name)
az aks get-credentials --resource-group $resource_group_name --name $kubernetes_cluster_name
kubectl get nodes
```

