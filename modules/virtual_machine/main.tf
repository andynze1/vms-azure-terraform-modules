
#######################################
resource "azurerm_linux_virtual_machine" "automation-server" {
  name                = var.vms
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ubuntu-keypair.public_key_openssh
  }

  network_interface_ids = [var.network_interface_id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/app-scripts/install.sh")

  depends_on = [var.network_interface_id]

  tags = var.tags
}

resource "tls_private_key" "ubuntu-keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ubuntu-pem-key" {
  content         = tls_private_key.ubuntu-keypair.private_key_pem
  filename        = "ubuntu-keypair.pem"
  file_permission = "0400"
  depends_on      = [tls_private_key.ubuntu-keypair]
}
################################