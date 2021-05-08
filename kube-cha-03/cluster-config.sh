#!/bin/bash

# should be an address space that is within the vnet adddress space
# but does not overlap with any other subnet address space
addressPrefix=10.2.1.0/24
clusterName=myAKSClusterwl
# Create subnet for AKS cluster
SUBNET_ID=$(az network vnet subnet create -n aks-subnet -g teamResources --vnet-name vnet --address-prefix $addressPrefix --query "id" -o tsv)
//-----If not in the same tenant----
az login -t TENANTID  --allow-no-subscriptions
TENANTID_K8SRBAC= TENANTID
//----------------------
# Create an Azure AD group
az ad group create --display-name myAKSAdminGroup --mail-nickname myAKSAdminGroup


az aks create \
    --resource-group teamResources \
    --name $clusterName \
    --generate-ssh-keys \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --vm-set-type VirtualMachineScaleSets \
    --node-count 2 \
    --docker-bridge-address 172.17.0.1/16 \
    --service-cidr 172.38.0.0/16 \
    --dns-service-ip 172.38.0.10 \
    --network-policy azure \
    --enable-aad \
    --aad-admin-group-object-ids 

az aks get-credentials --name $clusterName --resource-group teamResources 

AD_UPN=
AD_UPN=$(az ad signed-in-user show --query userPrincipalName -o tsv)
echo "User principal name for current user:" $AD_UPN

az aks update -n $clusterName -g teamResources --attach-acr registryklg3329