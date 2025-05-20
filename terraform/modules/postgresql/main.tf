resource "azurerm_postgresql_flexible_server" "pgsql-1" {
  name                   = var.db_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  sku_name               = "B_Standard_B1ms"
  version                = "15"
  storage_mb             = 32768
  zone                   = "1"

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }

  tags = var.tags
}
