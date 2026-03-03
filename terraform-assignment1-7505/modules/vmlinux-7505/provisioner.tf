resource "azurerm_virtual_machine_extension" "nw_ext" {
  for_each            = azurerm_linux_virtual_machine.linux_vm
  name                = "${each.value.name}-nwext"
  virtual_machine_id  = each.value.id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "am_ext" {
  for_each            = azurerm_linux_virtual_machine.linux_vm
  name                = "${each.value.name}-amext"
  virtual_machine_id  = each.value.id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  type_handler_version = "1.27"
}

resource "null_resource" "linux_hostname" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  connection {
    type        = "ssh"
    host        = each.value.public_ip_address
    user        = var.admin_username
    private_key = file(var.admin_ssh_private_key)
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hostname:'",
      "hostname"
    ]
  }
}