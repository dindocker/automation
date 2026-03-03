terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten10007505RG"
    storage_account_name = "tfstaten10007505sa"
    container_name       = "tfstatefiles"
    key                  = "assignment1-7505.tfstate"
  }
}