output "windows_availability_set_name" {
  value = azurerm_availability_set.win_avs.name
}

output "vm_hostnames" {
  value = azurerm_windows_virtual_machine.win_vm[*].name
}

output "private_ips" {
  value = [
    for nic in azurerm_network_interface.win_nic :
    nic.ip_configuration[0].private_ip_address
  ]
}

output "public_ips" {
  value = azurerm_public_ip.win_pip[*].ip_address
}

output "vm_fqdns" {
  value = azurerm_public_ip.win_pip[*].fqdn
}

########### Expose VMs ID ############

output "vm_id" {
  description = "Windows VM ID"
  value = azurerm_windows_virtual_machine.win_vm[0].id
}