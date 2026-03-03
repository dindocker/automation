output "datadisk_names" {
  value = [for d in azurerm_managed_disk.data_disk : d.name]
}