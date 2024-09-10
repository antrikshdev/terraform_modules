resource "azurerm_virtual_network_peering" "peer1" {
  name                         = var.peer1_name
  resource_group_name          = var.resource_group_name_peer1
  virtual_network_name         = var.virtual_network_name_peer1
  remote_virtual_network_id    = var.remote_virtual_network_id_peer1
  allow_virtual_network_access = var.allow_virtual_network_access_peer1
  allow_forwarded_traffic      = var.allow_forwarded_traffic_peer1
  allow_gateway_transit        = var.allow_gateway_transit_peer1
  use_remote_gateways          = var.use_remote_gateways_peer1
  triggers                     = var.triggers_peer1
}

resource "azurerm_virtual_network_peering" "peer2" {
  count                        = var.enable_double_peer ? 1 : 0
  name                         = var.peer2_name
  resource_group_name          = var.resource_group_name_peer2
  virtual_network_name         = var.virtual_network_name_peer2
  remote_virtual_network_id    = var.remote_virtual_network_id_peer2
  allow_virtual_network_access = var.allow_virtual_network_access_peer2
  allow_forwarded_traffic      = var.allow_forwarded_traffic_peer2
  allow_gateway_transit        = var.allow_gateway_transit_peer2
  use_remote_gateways          = var.use_remote_gateways_peer2
  triggers                     = var.triggers_peer2
}