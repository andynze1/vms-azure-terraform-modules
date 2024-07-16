variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
#  default     = "eno-resource-group"
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
#  default     = "East US"
}

variable "virtual_network_name" {
  description = "This defines the name of the virtual network"
  type        = string
#  default = "eno-virtual-network"
}

variable "virtual_network_address_space" {
  description = "This defines the address space of the virtual network"
  type        = string
#  default = "10.0.0.0/16"
}

variable "azurerm_public_ip" {
  description = "Public IP Address"
  type        = string
  default     = "public-ip"
}

variable "public_subnet" {
  description = "Public Subnet"
  type = object({
    name           = string
    address_prefix = string
  })
  default = {
    name           = "public-subnet"
    address_prefix = null  # Default value is not specific to an environment
  }
}

variable "private_subnet" {
  description = "Private Subnet"
  type = object({
    name           = string
    address_prefix = string
  })
  default = {
    name           = "private-subnet"
    address_prefix = null  # Default value is not specific to an environment
  }
}

variable "my_ip_address" {
  description = "Your IP address with a /32 subnet mask"
  type        = string
  default     = "146.85.136.101/32" # Replace with your actual IP address
}

variable "network_interface" {
  description = "Network Interface"
  type        = string
  default     = "eno-network-interface"
}

variable "network_security_group" {
  description = "This defines the security groups"
  type        = string
#  default     = "East US"
}

# variable "virtual_network_name" {
#   description = "Virtual network configuration"
#   type = object({
#     name          = string
#     address_space = list(string)
#   })
#   default = {
#     name          = "eno-virtual-network"
#     address_space = ["10.0.0.0/16"]
#   }
# }
