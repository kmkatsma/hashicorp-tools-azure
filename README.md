#login
az login

#create a resource group
az group create -n rg-hashicorp-demo -l eastus

#get info to create a service principal
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

#get subscription id
az account show --query "{ subscription_id: id }"

#set environment variables
setx ARM_SUBSCRIPTION_ID XXXXX
setx ARM_TENANT_ID XXXXX
setx ARM_CLIENT_ID XXXXX
setx ARM_CLIENT_SECRET XXXXXX

#create image
packer build ubuntu-consul.json

#create vm
az vm create --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --image ubuntu-nginx --admin-username azureuser --generate-ssh-keys

#open port
az vm open-port --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --port 80

# https://github.com/hashicorp/terraform-azurerm-consul

## problems with consul-cluster implementation

-module "consul_cluster" has incorrect arguments for consul_run
-extra/missing variables, incorrectly named
-no examples on how to add clients into cluster
-no logic to generate ssh keys
-no way to view AMI id - added command into the packer steps

# https://github.com/hashicorp/azure-consul

## steps to deal issues to get consul

-Enable OpenSSH on windows10 (windows service)
-chmod doesn't work on windows machines
-Copy the output of the deploy into private.pem manually
-Change the permissions to remove all but full control for owner
-then able to ssh-add and ssh the keys
