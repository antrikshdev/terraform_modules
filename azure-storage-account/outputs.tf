output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_container_name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.container[0].name
}

output "primary_access_key" {
  description = "The primary access key of the storage account"
  value       = azurerm_storage_account.storage_account.primary_access_key
}

output "primary_connection_string" {
  description = "The primary connection string key of the storage account"
  value       = azurerm_storage_account.storage_account.primary_connection_string
}

