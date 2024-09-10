output "peer1_id" {
  value       = azurerm_virtual_network_peering.peer1.id
  description = "ID of the created Virtual Network Peering for the first peer."
}

output "peer2_id" {
  value       = azurerm_virtual_network_peering.peer2[0].id
  description = "ID of the created Virtual Network Peering for the second peer."
}