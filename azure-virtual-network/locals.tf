locals {
  default_vnet_tags = {
    resourceName = var.name
    env          = var.env
  }
}