resource "azurerm_log_analytics_workspace" "law" {
  name                = "7505-LAW"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "n7505-RSV"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "st7505common"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}