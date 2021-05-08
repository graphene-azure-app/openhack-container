#!/bin/bash

AKS_ID=$(az aks show \
    --resource-group teamResources \
    --name $clusterName \
    --query id -o tsv)

## Web Dev
WEBDEV_GROUP_ID=$(az ad group create \
    --display-name Web-dev \
    --mail-nickname webdev \
    --query objectId -o tsv)

## Api Dev
APIDEV_GROUP_ID=$(az ad group create \
    --display-name Api-dev \
    --mail-nickname apidev \
    --query objectId -o tsv)
===============================================================
DID NOT DO THE FOLLOWING STEP
DEFAULT TENANT: az login -t 
===============================================================

az role assignment create \
    --assignee $WEBDEV_GROUP_ID \
    --role "Azure Kubernetes Service Cluster User Role" \
    --scope $AKS_ID

az role assignment create \
    --assignee $APIDEV_GROUP_ID \
    --role "Azure Kubernetes Service Cluster User Role" \
    --scope $AKS_ID
