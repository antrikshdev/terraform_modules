locals {
  default_nat_gateway_tags = {
    resourceName = var.nat_gateway_name
    env          = var.env
  }
  default_route_table_tags = {
    resourceName = var.route_name
    env          = var.env
  }
}