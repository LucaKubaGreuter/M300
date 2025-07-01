resource "azurerm_storage_account" "stacc-1" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {}

  tags = var.tags
}

resource "azurerm_storage_container" "stcontainer-1" {
  name = var.container_names[0]
  storage_account_name = azurerm_storage_account.stacc-1.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stcontainer-2" {
  name = var.container_names[1]
  storage_account_name = azurerm_storage_account.stacc-1.name
  container_access_type = "private"
}