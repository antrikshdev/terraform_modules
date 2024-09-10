locals {
  default_nsg_tags = {
    resourceName = var.name
    env          = var.env
  }
}