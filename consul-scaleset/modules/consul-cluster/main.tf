terraform {
  required_version = ">= 0.10.0"
}

resource "azurerm_virtual_machine_scale_set" "consul_with_load_balancer" {
  count = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  name = "${var.cluster_name}"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  upgrade_policy_mode = "Manual"

  sku {
    name = "${var.instance_size}"
    tier = "${var.instance_tier}"
    capacity = "${var.cluster_size}"
  }

  os_profile {
    computer_name_prefix = "${var.computer_name_prefix}"
    admin_username = "${var.admin_user_name}"
    admin_password = "Passwword1234"
    custom_data = "${var.custom_data}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name = "ConsulNetworkProfile"
    primary = true

    ip_configuration {
      name = "ConsulIPConfiguration"
      primary = true
      load_balancer_backend_address_pool_ids = [
        "${azurerm_lb_backend_address_pool.consul_bepool.id}"]
      load_balancer_inbound_nat_rules_ids = ["${element(azurerm_lb_nat_pool.consul_lbnatpool.*.id, count.index)}"]
      subnet_id = "${azurerm_subnet.myterraformsubnet.id}"
    }
  }

  storage_profile_image_reference {
    id = "${var.image_id}"
  }

  storage_profile_os_disk {
    name = ""
    caching = "ReadWrite"
    create_option = "FromImage"
    os_type = "Linux"
    managed_disk_type = "Standard_LRS"
  }

  tags {
    scaleSetName = "${var.cluster_name}"
  }
}

#---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP AND RULES FOR SSH
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_network_security_group" "consul" {
  name = "${var.cluster_name}"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_network_security_rule" "ssh" {
  count = "${length(var.allowed_ssh_cidr_blocks)}"

  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "22"
  direction = "Inbound"
  name = "SSH${count.index}"
  network_security_group_name = "${azurerm_network_security_group.consul.name}"
  priority = "${100 + count.index}"
  protocol = "Tcp"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  source_address_prefix = "${element(var.allowed_ssh_cidr_blocks, count.index)}"
  source_port_range = "1024-65535"
}

# ---------------------------------------------------------------------------------------------------------------------
# THE CONSUL-SPECIFIC INBOUND/OUTBOUND RULES COME FROM THE CONSUL-SECURITY-GROUP-RULES MODULE
# ---------------------------------------------------------------------------------------------------------------------

module "security_group_rules" {
  source = "../consul-security-group-rules"

  security_group_name = "${azurerm_network_security_group.consul.name}"
  resource_group_name ="${azurerm_resource_group.rg.name}"

  server_rpc_port = "${var.server_rpc_port}"
  cli_rpc_port    = "${var.cli_rpc_port}"
  serf_lan_port   = "${var.serf_lan_port}"
  serf_wan_port   = "${var.serf_wan_port}"
  http_api_port   = "${var.http_api_port}"
  dns_port        = "${var.dns_port}"
}
