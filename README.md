# Technical Guide to Repo

There's several subprojects folders containing different components/approaches to solution

- **consul-app-service** - node app for working with consul, uses nestjs cloud libary that could not compile in docker
- **consul-app-service2** - stripped down node app for working with consul, using only npm consul package
- **consul-scaleset** - terraform/packer image based solution for deploying consul to azure with scaleset. Based on https://github.com/hashicorp/terraform-azurerm-consul. Numerous problems with this solution, which was apparently cloned from AWS solution and is not fully baked for Azure
- **consul-vms** - terraform/vm solution for deploying consul cluster to azure, with jumpboxe. Based on https://github.com/hashicorp/azure-consul. Added an Ubunto client consul VM.
- **consul-nomad-vms** - terraform/vm solution for deploying consult + nomad to azure, with jumpbox. Based on [https://github.com/hashicorp/azure-consul]. with additional Nomad configuration added. Also added Ubunto client consul/nomad VM.
- **packer-images** - containers initial test nginx image, and packer image for consul used with consul-scaleset.

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

## Local installs of terraform, packer

- download and install terraform and packer exes, add location to path

## Create image from terraform-azurm-consul

- packer build ubuntu-consul.json
- create vm from image syntax

```
az vm create --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --image ubuntu-nginx --admin-username azureuser --generate-ssh-keys
```

- open port to vm syntax

```
az vm open-port --resource-group rg-hashicorp-demo --name vm-ubuntu-nginx --port 80
```

# Consul Cluster solution

- based on example solution here: https://github.com/hashicorp/terraform-azurerm-consul
- this solution is cut and paste conversion of the AWS cluster solution, and the necessary changes to run in Azure are incomplete. See below for some issues.

## Problems with consul-cluster implementation

- module "consul_cluster" has incorrect arguments for consul_run
- extra/missing variables, incorrectly named
- no examples on how to add clients into cluster
- no logic to generate ssh keys
- no way to view AMI id - added command into the packer steps

# Consul VMs solution

- based on the example solution here https://github.com/hashicorp/azure-consul s
- created copy of needed files in consul-vms folder in repo.
- To execute:

  - change directory to consul-vms/single-region
  - run terraform init
  - run terraform apply, confirm with yes
  - if on windows, the creation of private_key.pem seems to fail consistently. To do ssh, the output for the private key must be saved manually into private_key.pem file after terraform apply completes. This file permissions must be modified to only allow owner full access, and no other inherited access.
  - after completion of the terraform deploy (and private key creation), run terraform output to get list of ports for SSH.
  - wait a few minutes for server setup to complete in background (install of consul takes few minutes as this happens at startup of VMs)
  - use the instructions [here](ssh.md) for SSH to jumpbox, then SSH to one of the servers.
  - run consul members to see that that are running.
  - use the instructions [here](docker-run-notes.md) to start docker container manually, and check that consul lists service

## Issues in azure-consul solution

- Enable OpenSSH on windows10 (creates windows service; start it)
- chmod doesn't work on windows machines
  - Must copy the output private key in the deploy into private.pem manually
  - alternative is to install cygwin64, add to path
  - Change the permissions to remove all but full control for owner
  - Then ssh-add the private.pem file, and can ssh using the keys
- Re-runs of terraform always trigger the exec to create a new ssh key
  - seems like need to update that will create ssh on first run if needed, but use private-pem if finds it
  - seems like this _is_ in the scripts, but not functioning

# Nomad + Consul solution

- The consul-In the consul-nomad-vms folder builds on the consul-vms solution and adds nomad configuration for the vm servers and client.
- Additional configuration for running nomad under systemd is added to the
- To run this example:
  - make sure environment variables have been set as per references at start of README.
  - change directory to consul-nomad-vms/single-region folder
  - run terrform init
  - run terraform apply, confirm with yes
  - if on windows, the creation of private_key.pem seems to fail consistently. To do ssh, the output for the private key must be saved manually into private_key.pem file after terraform apply completes. This file permissions must be modified to only allow owner full access, and no other inherited access.
  - after completion of the terraform deploy (and private key creation), run terraform output to get list of ports for SSH.
  - wait a few minutes for server setup to complete in background (install of consul/nomad takes few minutes as this happens at startup of VMs)
  - use the instructions [here](ssh.md) for SSH to jumpbox, then SSH to one of the servers.
  - run consul members to see that that are running.
  - use the instructions [here](docker-run-notes.md) to start docker container manually, and check that consul lists service
  - can run nomad status to verify nomad is running.
  - to schedule with nomad, stop the docker container, and then follow instructions for running nomad job [here](nomad-run-notes.md)
