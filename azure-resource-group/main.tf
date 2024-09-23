resource "azurerm_resource_group" "this" {
  name       = var.name
  location   = var.location
  managed_by = var.managed_by

  tags = merge(local.default_resource_group_tags, var.tags)
}

#Assign owner role
module "role-assignment-owner" {
  source = "../azure-role-assignment"

  count                = var.owner_id == null ? 0 : 1
  principal_id         = var.owner_id
  role_definition_name = "Owner"
  assignment_scope     = azurerm_resource_group.this.id
}

#Assign contributor role
module "role-assignment-contributor" {
  source = "../azure-role-assignment"

  count                = var.contributor_id == null ? 0 : 1
  principal_id         = var.contributor_id
  role_definition_name = "Contributor"
  assignment_scope     = azurerm_resource_group.this.id
}

#Assign reader role
module "role-assignment-reader" {
  source = "../azure-role-assignment"

  count                = var.reader_id == null ? 0 : 1
  principal_id         = var.reader_id
  role_definition_name = "Reader"
  assignment_scope     = azurerm_resource_group.this.id
}