WORKSPACE=aksworkshop-workspace-$RANDOM
az resource create --resource-type Microsoft.OperationalInsights/workspaces \
        --name $WORKSPACE \
        --resource-group teamResources \
        --location westus \
        --properties '{}' -o table

WORKSPACE_ID=$(az resource show --resource-type Microsoft.OperationalInsights/workspaces \
    --resource-group teamResources \
    --name $WORKSPACE \
    --query "id" -o tsv)

az aks enable-addons \
    --resource-group teamResources \
    --name ohClusterWL \
    --addons monitoring \
    --workspace-resource-id $WORKSPACE_ID