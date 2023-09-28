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
echo "Storage account name:"
echo ""
az storage account list -g tfstate-aks | jq '.[].name' -r

## insert storage account name on providers.tf

sed -i "s/sa_name/$(az storage account list -g tfstate-aks | jq '.[].name' -r)/g" providers.tf
