output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the created subnet"
}

output "nsg_id" {
  value       = try(module.nsg[0].id, null)
  description = "ID of the created nsg"
}