
module "prod_networking_module" {
  source                        = "./modules/networking"
  resource_group_name           = "prod-resource-group"
  resource_group_location       = "East US"
  virtual_network_name          = "prod-virtual-network"
  virtual_network_address_space = "10.0.0.0/16"
  network_security_group        = "prod_security_group"

  public_subnet = {
    name           = "prod-public-subnet"
    address_prefix = "10.0.0.0/24" # Adjust based on prod-virtual-network
  }
  private_subnet = {
    name           = "prod-private-subnet"
    address_prefix = "10.0.1.0/24" # Adjust based on prod-virtual-network
  }
}

# resource "tls_private_key" "ubuntu-keypair" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "ubuntu-pem-key" {
#   content         = tls_private_key.ubuntu-keypair.private_key_pem
#   filename        = "ubuntu-keypair.pem"
#   file_permission = "0400"
#   depends_on      = [tls_private_key.ubuntu-keypair]
# }


# output "jenkins_vm_public_ip" {
#   description = "The public IP addresses of the Jenkins VMs."
#   value       = module.jenkins_vm_module.vm_public_ip
# }

module "jenkins_vm_module" {
  source               = "./modules/virtual_machine"
  vms              = "jenkins-server"
  resource_group_name  = module.prod_networking_module.resource_group_name
  location             = module.prod_networking_module.resource_group_location
  vm_size              = "Standard_D2s_v3"
  admin_username       = "adminuser"
  network_interface_id = module.prod_networking_module.network_interface_id
  network_dependencies = [
    module.prod_networking_module.resource_group_name,
    module.prod_networking_module.virtual_network_id,
    module.prod_networking_module.network_security_group_id
  ]
  tags = {
    environment = "production"
  }
}



# module "stage_networking_module" {
#   source                        = "./networking"
#   resource_group_name           = "stage-resource-group"
#   resource_group_location       = "East US"
#   virtual_network_name          = "stage-virtual-network"
#   virtual_network_address_space = "10.1.0.0/16"
#   network_security_group        = "prod_security_group"

#   public_subnet = {
#     name           = "stage-public-subnet"
#     address_prefix = "10.1.0.0/24" # Adjust based on stage-virtual-network
#   }
#   private_subnet = {
#     name           = "stage-private-subnet"
#     address_prefix = "10.1.1.0/24" # Adjust based on stage-virtual-network
#   }
# }










# module "dev_networking_module" {
#   source                    = "./networking"
#   resource_group_name       = "dev-resource-group"
#   resource_group_location   = "East US"
#   virtual_network_name      = "dev-virtual-network"
#   virtual_network_address_space = "10.2.0.0/16"
#   network_security_group        = "prod_security_group"

#   public_subnet = {
#     name           = "dev-public-subnet"
#     address_prefix = "10.2.0.0/24"  # Adjust based on stage-virtual-network
#   }
#   private_subnet = {
#     name           = "dev-private-subnet"
#     address_prefix = "10.2.1.0/24"  # Adjust based on stage-virtual-network
#   }
# }