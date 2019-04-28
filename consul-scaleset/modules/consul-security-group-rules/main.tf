# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP RULES THAT CONTROL WHAT TRAFFIC CAN GO IN AND OUT OF A CONSUL CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_network_security_rule" "allow_server_rpc_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.server_rpc_port}"
  direction = "Inbound"
  name = "ServerRPC1"
  network_security_group_name = "${var.security_group_name}"
  priority = "200"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_cli_rpc_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.cli_rpc_port}"
  direction = "Inbound"
  name = "CLIRPC1"
  network_security_group_name = "${var.security_group_name}"
  priority = "250"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_serf_lan_tcp_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.serf_lan_port}"
  direction = "Inbound"
  name = "SerfLan1"
  network_security_group_name = "${var.security_group_name}"
  priority = "300"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_serf_lan_udp_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.serf_lan_port}"
  direction = "Inbound"
  name = "SerfLanUdp1"
  network_security_group_name = "${var.security_group_name}"
  priority = "350"
  protocol = "Udp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_serf_wan_tcp_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.serf_wan_port}"
  direction = "Inbound"
  name = "SerfWan1"
  network_security_group_name = "${var.security_group_name}"
  priority = "400"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_serf_wan_udp_inbound" {

  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.serf_wan_port}"
  direction = "Inbound"
  name = "SerfWanUdp1"
  network_security_group_name = "${var.security_group_name}"
  priority = "451"
  protocol = "Udp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_http_api_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.http_api_port}"
  direction = "Inbound"
  name = "HttpApi1"
  network_security_group_name = "${var.security_group_name}"
  priority = "500"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_dns_tcp_inbound" {
  
  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.dns_port}"
  direction = "Inbound"
  name = "Dns1"
  network_security_group_name = "${var.security_group_name}"
  priority = "550"
  protocol = "Tcp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "allow_dns_udp_inbound" {

  access = "Allow"
  destination_address_prefix = "*"
  destination_port_range = "${var.dns_port}"
  direction = "Inbound"
  name = "Dns1"
  network_security_group_name = "${var.security_group_name}"
  priority = "600"
  protocol = "Udp"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "1024-65535"
}

resource "azurerm_network_security_rule" "denyall" {
  access = "Deny"
  destination_address_prefix = "*"
  destination_port_range = "*"
  direction = "Inbound"
  name = "DenyAll"
  network_security_group_name = "${var.security_group_name}"
  priority = 999
  protocol = "*"
  resource_group_name = "${var.resource_group_name}"
  source_address_prefix = "*"
  source_port_range = "*"
}
