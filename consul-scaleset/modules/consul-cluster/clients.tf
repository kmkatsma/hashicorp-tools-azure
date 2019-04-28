
/*resource "azurerm_virtual_machine" "client1" {
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
}*/