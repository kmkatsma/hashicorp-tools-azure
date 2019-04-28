resource "azurerm_resource_group" "rg" {
  location  = "eastus"
  name      = "${var.resource_group_name}"
}

resource "azurerm_storage_account" "sa" {
  location= "eastus"
  name                      = "${var.storage_account_name}"  
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_virtual_network" "consul_cluster" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags {
        environment = "Terraform Demo"
    }
}
 
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "mySubnet"
     resource_group_name = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.consul_cluster.name}"
    address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "consul_access" {
  count                         = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  name                          = "${var.cluster_name}_access"
  location                      = "${var.location}"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation  = "static"
  domain_name_label             = "${var.cluster_name}"
}

resource "azurerm_lb" "consul_access" {
  count               = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  name                = "${var.cluster_name}_access"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  frontend_ip_configuration {
    name                  = "PublicIPAddress"
    public_ip_address_id  = "${azurerm_public_ip.consul_access.id}"
  }
}

resource "azurerm_lb_nat_pool" "consul_lbnatpool" {
  count                           = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  resource_group_name             = "${azurerm_resource_group.rg.name}"
  name                            = "ssh"
  loadbalancer_id                 = "${azurerm_lb.consul_access.id}"
  protocol                        = "Tcp"
  frontend_port_start             = 2200
  frontend_port_end               = 2299
  backend_port                    = 22
  frontend_ip_configuration_name  = "PublicIPAddress"
}

resource "azurerm_lb_nat_pool" "consul_lbnatpool_rpc" {
  count                           = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  resource_group_name             = "${azurerm_resource_group.rg.name}"
  name                            = "rpc"
  loadbalancer_id                 = "${azurerm_lb.consul_access.id}"
  protocol                        = "Tcp"
  frontend_port_start             = 8300
  frontend_port_end               = 8399
  backend_port                    = 8300
  frontend_ip_configuration_name  = "PublicIPAddress"
}

resource "azurerm_lb_nat_pool" "consul_lbnatpool_http" {
  count                         = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  name                          = "http"
  loadbalancer_id               = "${azurerm_lb.consul_access.id}"
  protocol                      = "Tcp"
  frontend_port_start           = 8500
  frontend_port_end             = 8599
  backend_port                  = 8500
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_backend_address_pool" "consul_bepool" {
  count                 = "${var.associate_public_ip_address_load_balancer ? 1 : 0}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  loadbalancer_id       = "${azurerm_lb.consul_access.id}"
  name                  = "BackEndAddressPool"
}


