# Get Resource Group, VNet and Subnet
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "store_account" {
  count               = var.storage_account_name != null ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_virtual_network" "vnet" {
  provider            = azurerm.vnet
  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_name_rg
}

data "azurerm_subnet" "snet" {
  provider             = azurerm.vnet
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.virtual_network_name_rg
}
