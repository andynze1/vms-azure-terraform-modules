# modules/virtual_machine/outputs.tf

output "vm_public_ip" {
  description = "The public IP of the virtual machine."
  value       =  azurerm_linux_virtual_machine.automation-server.public_ip_address
}

# output "vm_public_ips" {
#   description = "The public IP addresses of the virtual machines."
#   value       = { for k, vm in azurerm_linux_virtual_machine.vms : k => vm.public_ip_address }
# }

# output "vm_public_ips" {
#   description = "The public IP addresses of the VMs."
#   value = {
#     for vm in azurerm_linux_virtual_machine.vms :  vm.name => vm.public_ip_address
#   }
# }