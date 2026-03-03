resource "azurerm_virtual_machine_extension" "antimalware" {
  count               = var.nb_count
  name                = "${var.win_name}-antimalware-${count.index}"
  virtual_machine_id  = azurerm_windows_virtual_machine.win_vm[count.index].id
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.5"

  settings = <<SETTINGS
{
  "AntimalwareEnabled": true,
  "RealtimeProtectionEnabled": true,
  "ScheduledScanSettings": {
    "isEnabled": true,
    "day": 0,
    "time": 120,
    "scanType": "Quick"
  }
}
SETTINGS
}