#Create the subnet
resource "azurerm_subnet" "subnet" {
  name                                          = var.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids
  service_endpoints                             = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegations == null ? [] : var.delegations

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

#Create Network Security Group with rules
module "nsg" {
  source = "../azure-nsg"

  count               = var.nsg_name == null ? 0 : 1
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  outbound_rules      = var.nsg_outbound_rules
  inbound_rules       = var.nsg_inbound_rules
  env                 = var.env
}

#Associate Network Security Group with the subnet
module "subnet_nsg_association" {
  source = "../azure-nsg-association"

  count                     = var.nsg_name == null ? (var.existing_nsg_id == null ? 0 : 1) : 1
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = coalesce(var.existing_nsg_id, module.nsg[0].id)
}

#Create Route Table with routes
module "route_table" {
  source = "../azure-route-table"

  count               = var.route_name == null ? 0 : 1
  route_name          = var.route_name
  location            = var.location
  resource_group_name = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  route_list          = var.route_list
  env                 = var.env
  tags                = merge(local.default_route_table_tags, var.route_tags)
}

#Associate Route Table with the subnet
module "route_table_association" {
  source = "../azure-route-table-association"

  count          = var.route_name == null ? (var.existing_route_table_id == null ? 0 : 1) : 1
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = coalesce(var.existing_route_table_id, module.route_table[0].id)
}

#Create NAT gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  count                   = var.nat_gateway_name == null ? 0 : 1
  name                    = var.nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.nat_gateway_sku_name
  idle_timeout_in_minutes = var.nat_gateway_idle_timeout_in_minutes
  zones                   = var.nat_gateway_zones

  tags = merge(local.default_nat_gateway_tags, var.tags)

}

#Associate NAT gateway with the subnet
resource "azurerm_subnet_nat_gateway_association" "nat_gateway_assoc" {
  count          = var.nat_gateway_name == null ? (var.existing_nat_gateway_id == null ? 0 : 1) : 1
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = coalesce(var.existing_nat_gateway_id, azurerm_nat_gateway.nat_gateway[0].id)
}