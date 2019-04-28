module "consul_cluster" {

  # TODO: update this to the final URL
  # Use version v0.0.1 of the consul-cluster module
  source = "./modules/consul-cluster"

  # Specify the ID of the Consul AMI. You should build this using the scripts in the install-consul module.
  image_id = "/subscriptions/32b732ea-eed0-48cc-be1a-178840791836/resourceGroups/rg-hashicorp-demo/providers/Microsoft.Compute/images/ubuntu-consul"
  
  # Add this tag to each node in the cluster
  cluster_tag_key   = "consul-cluster"
  cluster_tag_value = "consul-cluster-example"
  
  # Configure and start Consul during boot. It will automatically form a cluster with all nodes that have that same tag. 
  custom_data = <<-EOF
              #!/bin/bash
              /opt/consul/bin/run-consul --server --cluster-tag-key consul-cluster --subscription-id "${var.subscription_id}" --tenant-id "${var.tenant_id}"
   --client-id "${var.client_id}" --secret-access-key "${var.secret_access_key}"
              EOF
  
  # ... See vars.tf for the other parameters you must define for the consul-cluster module
  location = "East US"
  resource_group_name = "rg-hashicorp-demo-consul2"
  storage_account_name = "sahashicorpdemoconsul"
  cluster_name = "consul-cluster"
  instance_size = "Standard_B1ls"
   key_data = "./id_rsa.pub"
}