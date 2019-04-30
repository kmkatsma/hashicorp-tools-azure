# Technical Guide to Repo

There's several subprojects folders containing different components/approaches to solution

- consul-app-service - node app for working with consul, uses nestjs cloud libary that could not compile in docker
- consul-app-service2 - stripped down node app for working with consul, using only npm consul package
- consul-scaleset - terraform/packer image based solution for deploying consul to azure with scaleset. Based on [https://github.com/hashicorp/terraform-azurerm-consul]. Numerous problems with this solution, which was apparently cloned from AWS solution and is not fully baked for Azure
- consult-vms - terraform/vm solution for deploying consul cluster to azure, with jumpboxes for consul servers. based on [https://github.com/hashicorp/azure-consul]. Added an Ubunto client consul VM.
- packer-images - containers initial test nginx image, and packer image for consul used with consul-scaleset.

## Requirements for running Terraform scripts with azure (using local state)

- Run 'az login' at command line
- create a service principal to use with terraform deploys

```
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
```

- get subscription id

```
az account show --query "{ subscription_id: id }"
```

- set environment variables

```
setx ARM_SUBSCRIPTION_ID XXXXX
setx ARM_TENANT_ID XXXXX
setx ARM_CLIENT_ID XXXXX
setx ARM_CLIENT_SECRET XXXXXX
```

## local installs of terraform, packer

- download and install terraform and packer exes, add location to path

## create image from terraform-azurm-consul

- packer build ubuntu-consul.json
- create vm from image syntax

```
az vm create --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --image ubuntu-nginx --admin-username azureuser --generate-ssh-keys
```

- open port to vm syntax

```
az vm open-port --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --port 80
```

# https://github.com/hashicorp/terraform-azurerm-consul

## problems with consul-cluster implementation

- module "consul_cluster" has incorrect arguments for consul_run
- extra/missing variables, incorrectly named
- no examples on how to add clients into cluster
- no logic to generate ssh keys
- no way to view AMI id - added command into the packer steps

# https://github.com/hashicorp/azure-consul solution

- deployed default configuration
- run terraform output command and capture info for "jumphost_westus_ssh_connection_strings" setting, should see something like:

```
jumphost_westus_ssh_connection_strings = [
    ssh-add private_key.pem && ssh -A -i private_key.pem azure-user@40.83.169.18
]
```

- the information can be used from command shell to connect to jumpbox created by terraform deploy

```
ssh -A -i azure-user@40.83.169.12
```

- once connected to jumpbox, can use 'consul members' command to see consul servers.

- added scripts to create consul client vm
  - config with docker installed
- redeployed terraform; client 1 created
- ssh into client1 server with below command

```
 ssh azure-user@10.0.96.4
```

- run docker with commands below (linux example). First will run interactively, so better to do 2nd so can then test.

```
sudo docker run -it -p 3002:3002 --network=host  kmkatsma/ts-nest-consul-app2:basic
sudo docker run -d -p 3002:3002  --network=host --restart=always kmkatsma/ts-nest-consul-app2:basic
```

- after docker launched, run curl command below on the consul agent, and will see 'example' service listed. The node app started and registered itself.

```
curl http://127.0.0.1:8500/v1/agent/services
```

## Issues in azure-consul solution

- Enable OpenSSH on windows10 (creates windows service; start it)
- chmod doesn't work on windows machines
  - Must copy the output private key in the deploy into private.pem manually
  - alternative is to install cygwin64, add to path
  - Change the permissions to remove all but full control for owner
  - Then ssh-add the private.pem file, and can ssh using the keys
- issues - re-runs of terraform always trigger the exec to create a new ssh key
  - seems like need to update that will create ssh on first run if needed, but use private-pem if finds it
  - seems like this _is_ in the scripts, but not functioning
