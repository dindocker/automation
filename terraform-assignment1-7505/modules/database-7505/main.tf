resource "azurerm_postgresql_flexible_server" "db" {
  name                = "pg7505flex"
  resource_group_name = var.rg_name
  location            = var.location
  version             = "14"

  administrator_login    = var.admin_user
  administrator_password = var.admin_password

  sku_name   = "GP_Standard_D2s_v3"
  storage_mb = 32768

  backup_retention_days = 7
  public_network_access_enabled = true

  tags = var.tags
}