terraform {
  backend "azurerm" {
    resource_group_name  = "rg-lucgr-001"
    storage_account_name = "tfstateweather"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}