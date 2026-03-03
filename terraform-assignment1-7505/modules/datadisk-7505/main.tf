resource "azurerm_managed_disk" "data_disk" {
  for_each            = var.vm_ids
  name                = "${each.key}-datadisk"
  location            = var.location
  resource_group_name = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option       = "Empty"
  disk_size_gb        = 10
  tags                = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  for_each           = var.vm_ids
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = each.value
  lun                = 10
  caching            = "ReadWrite"
}