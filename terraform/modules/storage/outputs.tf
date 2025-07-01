output "storage_account_name" {
  value = azurerm_storage_account.stacc-1.name
}

output "storage_container_name-1" {
  value = azurerm_storage_container.stcontainer-1.name
}

output "storage_container_name-2" {
  value = azurerm_storage_container.stcontainer-2.name
}
