resource "azurerm_private_endpoint" "private_endpoint" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = var.custom_network_interface_name
  tags                          = merge(local.default_private_endpoint_tags, var.tags)

  private_service_connection {
    name                              = var.private_service_connection_name
    private_connection_resource_id    = var.private_connection_resource_id
    private_connection_resource_alias = var.private_connection_resource_alias
    is_manual_connection              = var.manual_connection
    subresource_names                 = var.subresource_names
    request_message                   = var.request_message
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  dynamic "ip_configuration" {
    for_each = var.ip_configurations == null ? [] : var.ip_configurations
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }
}