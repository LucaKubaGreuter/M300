output "postgresql_server_name" {
  value = azurerm_postgresql_flexible_server.pgsql-1.name
}

output "postgresql_fqdn" {
  value = azurerm_postgresql_flexible_server.pgsql-1.fqdn
}
