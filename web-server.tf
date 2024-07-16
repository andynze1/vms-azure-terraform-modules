# # Virtual Machine - EC2
# resource "azurerm_linux_virtual_machine" "jenkins-server" {
#   name                = "jenkins-server"
#   resource_group_name = module.prod_networking_module.resource_group_name
#   location            = module.prod_networking_module.resource_group_location
#   size                = "Standard_D2s_v3"
#   admin_username      = "adminuser"
#   # admin_password      = "AndyBest1"
#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = tls_private_key.ubuntu-keypair.public_key_openssh
#   }

#   network_interface_ids = [module.prod_networking_module.network_interface_id]
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts-gen2"
#     version   = "latest"
#   }
#   # bootstrap
#   # custom_data = base64encode(data.template_file.cloudinitdata.rendered)
#   custom_data = filebase64("${path.module}/app-scripts/install.sh")

#   depends_on = [
#     module.prod_networking_module.resource_group_name,
#     module.prod_networking_module.azurerm_virtual_network,
#     module.prod_networking_module.security_group,
#     tls_private_key.ubuntu-keypair
#   ]
# }

# # Create SSH RSA key of size 4096 bits
# resource "tls_private_key" "ubuntu-keypair" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# # Copy ssh key to local
# resource "local_file" "ubuntu-pem-key" {
#   content         = tls_private_key.ubuntu-keypair.private_key_pem
#   filename        = "ubuntu-keypair.pem"
#   file_permission = "0400"
#   depends_on      = [tls_private_key.ubuntu-keypair]
# }