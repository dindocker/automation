output "hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}

output "fqdns" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.fqdn]
}

output "private_ips" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].private_ip_address]
}

output "public_ips" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.ip_address]
}

####### Expose VM IDs and NIC IDs #######

output "vm_ids" {
  description = "Map of Linux VM IDs"
  value = { for k, vm in azurerm_linux_virtual_machine.linux_vm : k => vm.id }
}

output "nic_ids" {
  value = { for k, nic in azurerm_network_interface.linux_nic : k => nic.id }
}
output "ipconfig_names" {
  value = { for k, v in var.vm_names : k => "${v}-ipconfig" }
}