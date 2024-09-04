locals {
  default_private_endpoint_tags = {
    resourceName = var.name
    env          = var.env
  }
}