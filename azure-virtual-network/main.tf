resource "azurerm_virtual_network" "vnet" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  address_space           = var.address_space
  dns_servers             = var.dns_servers
  bgp_community           = var.bgp_community
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  tags                    = merge(local.default_vnet_tags, var.tags)

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan == null ? [] : [var.ddos_protection_plan]
    content {
      id     = lookup(ddos_protection_plan.value, "id")
      enable = lookup(ddos_protection_plan.value, "enable")
    }
  }
  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]
    content {
      enforcement = lookup(encryption.value, "enforcement")
    }
  }
}