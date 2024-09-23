locals {
  default_resource_group_tags = {
    resourceName = var.name
    env          = var.env
  }
}