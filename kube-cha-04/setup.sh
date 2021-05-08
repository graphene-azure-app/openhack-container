helm repo add csi-secrets-store-provider-azure https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts
helm install csi csi-secrets-store-provider-azure/csi-secrets-store-provider-azure

 az keyvault create -n tripkv -g teamResources --location westus

 az keyvault secret set --vault-name tripkv1 --name sqluser --value "sqladminkLg3329"

az keyvault secret set --vault-name tripkv1 --name sqlpassword --value "zT2bz3Yg3"

az keyvault secret set --vault-name tripkv1 --name sqlserver --value "sqlserverklg3329.database.windows.net"

az keyvault secret set --vault-name tripkv1 --name sqldb --value "mydrivingDB"

az aks show -g teamResources -n $clusterName --query identityProfile.kubeletidentity.clientId -o tsv

az keyvault set-policy -n tripkv1 --key-permissions get --spn 47c06f59-f13c-40c7-aab2-afe3568127f5
# set policy to access secrets in your Keyvault
az keyvault set-policy -n tripkv1 --secret-permissions get --spn 47c06f59-f13c-40c7-aab2-afe3568127f5
# set policy to access certs in your Keyvault
az keyvault set-policy -n tripkv1 --certificate-permissions get --spn 47c06f59-f13c-40c7-aab2-afe3568127f5