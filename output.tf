output "Jenkins-Server" {
  description = "The IP of the Jenkins Server."
  value       = module.jenkins_vm_module.vm_public_ip
  #  value       = module.jenkins_vm_module.vm_public_ip

  # azurerm_linux_virtual_machine.jenkins-server.public_ip_address
}