output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "resource_group_location" {
  value = azurerm_virtual_network.virtual_network.location
}

output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "public_subnet_id" {
  value = azurerm_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip.id
}

output "network_interface_id" {
  value = azurerm_network_interface.network_interface.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.security_group.id
}
