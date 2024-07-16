# modules/virtual_machine/variables.tf

variable "vms" {
  description = "The name of the virtual machine."
  type        = string
}

# variable "vms" {
#   description = "A map of virtual machines to create"
#   type = map(object({
#     name                 = string
#     vm_size              = string
#     admin_username       = string
#     public_key           = string
#     network_interface_id = string
#     custom_data_path     = string
#   }))
# }

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "network_dependencies" {
  description = "Dependencies for the network resources."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "network_interface_id" {
  description = "The ID of the network interface."
  type        = string
}

variable "vms_key" {
  description = "The username keypair for the virtual machine."
  type        = string
}