resource "azurerm_storage_account" "stacc-1" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "stcontainer-1" {
  name = var.container_name
  storage_account_name = azurerm_storage_account.stacc-1.name
  container_access_type = "private"
}