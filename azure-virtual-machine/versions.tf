terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.vnet]
      version               = ">=3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.48.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1.0"
    }
  }
}