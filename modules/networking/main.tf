resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network_address_space]

  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_subnet.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.private_subnet.address_prefix]

  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}

resource "azurerm_subnet" "public_subnet" {
  name                 = var.public_subnet.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.public_subnet.address_prefix]

  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.azurerm_public_ip
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  depends_on = [
    azurerm_virtual_network.virtual_network,
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  depends_on = [
    azurerm_virtual_network.virtual_network,
    azurerm_subnet.public_subnet,
    azurerm_resource_group.resource_group,
    azurerm_public_ip.public_ip
  ]
}

resource "azurerm_network_security_group" "security_group" {
  name                = var.network_security_group
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = local.network_security_group_rules
    content {
      name                       = "Allow-${security_rule.value.destination_port_range}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = lookup(security_rule.value, "source_address_prefix", "*")
      destination_address_prefix = "*"
    }
  }

  depends_on = [
    azurerm_resource_group.resource_group,
    azurerm_virtual_network.virtual_network,
    azurerm_network_interface.network_interface
  ]
}

resource "azurerm_network_interface_security_group_association" "network_sg_asso" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.security_group.id

  depends_on = [
    azurerm_network_interface.network_interface,
    azurerm_network_security_group.security_group
  ]
}
