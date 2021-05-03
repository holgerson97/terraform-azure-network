output "resource_group_name" {

  value = var.resourcegroup_name == null ? azurerm_resource_group.main[0].name : data.azurerm_resource_group.main[0].name

}

output "virtual_network_id" {

  value = azurerm_virtual_network.main[0].id

}

output "virtual_network_name" {

  value = azurerm_virtual_network.main[0].name

}

output "virtual_network_resource_group_name" {

  value = azurerm_virtual_network.main[0].resource_group_name

}

output "virtual_network_location" {

  value = azurerm_virtual_network.main[0].location

}

output "virtual_network_address_space" {

  value = azurerm_virtual_network.main[0].address_space

}

output "virtual_network_guid" {

  value = azurerm_virtual_network.main[0].guid

}

output "subnet_address_id" {

  value = azurerm_subnet.main[*].id

}

output "subnet_address_name" {

  value = azurerm_subnet.main[*].name

}

output "subnet_address_resource_group_name" {

  value = azurerm_subnet.main[*].resource_group_name

}

output "subnet_address_virtual_network_name" {

  value = azurerm_subnet.main[*].virtual_network_name

}

output "subnet_address_prefix" {

  value = azurerm_subnet.main[*].address_prefix

}

output "subnet_address_prefixes" {

  value = azurerm_subnet.main[*].address_prefixes

}

output "dns_servers_ip" {

  value = var.dns_servers

}