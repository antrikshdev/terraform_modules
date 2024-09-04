resource "random_id" "storage" {
  byte_length = 4
  keepers = {
    name = var.storage_account_name
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                              = "${lower(var.storage_account_name)}${random_id.storage.hex}"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  access_tier                       = var.access_tier
  account_kind                      = var.account_kind
  is_hns_enabled                    = var.is_hns_enabled
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  enable_https_traffic_only         = var.enable_https_traffic_only
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  min_tls_version                   = var.min_tls_version
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  public_network_access_enabled     = var.public_network_access_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  nfsv3_enabled                     = var.nfsv3_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  sftp_enabled                      = var.sftp_enabled
  allowed_copy_scope                = var.allowed_copy_scope


  dynamic "custom_domain" {
    for_each = try(var.custom_domain, [])
    content {
      name          = lookup(custom_domain.value, "name", null)
      use_subdomain = lookup(custom_domain.value, "use_subdomain", null)
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.customer_managed_key, [])
    content {
      key_vault_key_id          = lookup(customer_managed_key.value, "key_vault_key_id", null)
      user_assigned_identity_id = lookup(customer_managed_key.value, "user_assigned_identity_id", null)
    }
  }

  dynamic "identity" {
    for_each = try(var.identity, [])
    content {
      type         = lookup(identity.value, "key_vault_key_id", null)
      identity_ids = lookup(identity.value, "user_assigned_identity_id", null)
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties
    content {
      versioning_enabled            = lookup(blob_properties.value, "versioning_enabled", null)
      change_feed_enabled           = lookup(blob_properties.value, "change_feed_enabled", null)
      change_feed_retention_in_days = lookup(blob_properties.value, "change_feed_retention_in_days", null)
      default_service_version       = lookup(blob_properties.value, "default_service_version", null)
      last_access_time_enabled      = lookup(blob_properties.value, "last_access_time_enabled", null)

      dynamic "cors_rule" {
        for_each = coalesce(blob_properties.value["cors_rule"], [])
        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      delete_retention_policy {
        days = try(blob_properties.delete_retention_policy.days, 7)
      }

      container_delete_retention_policy {
        days = try(blob_properties.container_delete_retention_policy.days, 7)
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties
    content {
      dynamic "cors_rule" {
        for_each = try(queue_properties.value["cors_rule"], [])
        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      logging {
        delete                = lookup(queue_properties.value["logging"][0], "delete", true)
        read                  = lookup(queue_properties.value["logging"][0], "read", true)
        version               = lookup(queue_properties.value["logging"][0], "version", null)
        write                 = lookup(queue_properties.value["logging"][0], "write", true)
        retention_policy_days = lookup(queue_properties.value["logging"][0], "retention_policy_days", null)
      }

      dynamic "minute_metrics" {
        for_each = try(queue_properties.value["minute_metrics"], [])
        content {
          enabled               = lookup(minute_metrics.value, "enabled", null)
          version               = lookup(minute_metrics.value, "version", null)
          include_apis          = lookup(minute_metrics.value, "include_apis", null)
          retention_policy_days = lookup(minute_metrics.value, "retention_policy_days", null)
        }
      }

      dynamic "hour_metrics" {
        for_each = try(queue_properties.value["hour_metrics"], [])
        content {
          enabled               = lookup(hour_metrics.value, "enabled", null)
          version               = lookup(hour_metrics.value, "version", null)
          include_apis          = lookup(hour_metrics.value, "include_apis", null)
          retention_policy_days = lookup(hour_metrics.value, "retention_policy_days", null)
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties
    content {
      dynamic "cors_rule" {
        for_each = try(share_properties.value["cors_rule"], [])
        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      dynamic "retention_policy" {
        for_each = try(share_properties.value["retention_policy"], [])
        content {
          days = lookup(retention_policy.value, "days", null)
        }
      }

      dynamic "smb" {
        for_each = try(share_properties.value["smb"], {})
        content {
          versions                        = lookup(smb.value, "versions", [])
          authentication_types            = lookup(smb.value, "authentication_types", [])
          kerberos_ticket_encryption_type = lookup(smb.value, "kerberos_ticket_encryption_type", [])
          channel_encryption_type         = lookup(smb.value, "channel_encryption_type", [])
          multichannel_enabled            = lookup(smb.value, "multichannel_enabled", null)
        }
      }
    }
  }
  dynamic "network_rules" {
    for_each = var.network_rules
    content {
      default_action             = lookup(network_rules.value, "default_action", "Deny")
      bypass                     = lookup(network_rules.value, "bypass", ["AzureServices"])
      ip_rules                   = lookup(network_rules.value, "ip_rules", [])
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", [])

      dynamic "private_link_access" {
        for_each = try(network_rules.private_link_access, {})
        content {
          endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", "")
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", "")
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = try(var.azure_files_authentication, [])
    content {
      directory_type = lookup(azure_files_authentication.value, "directory_type", "AD")
      dynamic "active_directory" {
        for_each = try(azure_files_authentication.value["active_directory"], {})
        content {
          storage_sid         = lookup(active_directory.value, "storage_sid", null)
          domain_name         = lookup(active_directory.value, "domain_name", null)
          domain_sid          = lookup(active_directory.value, "domain_sid", null)
          domain_guid         = lookup(active_directory.value, "domain_guid", null)
          forest_name         = lookup(active_directory.value, "forest_name", null)
          netbios_domain_name = lookup(active_directory.value, "netbios_domain_name", null)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = try(var.static_website, [])
    content {
      index_document     = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
    }
  }

  dynamic "routing" {
    for_each = try(var.routing, [])
    content {
      publish_internet_endpoints  = lookup(routing.value, "publish_internet_endpoints", null)
      publish_microsoft_endpoints = lookup(routing.value, "publish_microsoft_endpoints", null)
      choice                      = lookup(routing.value, "choice", null)
    }
  }

  dynamic "immutability_policy" {
    for_each = try(var.immutability_policy, [])
    content {
      allow_protected_append_writes = lookup(immutability_policy.value, "allow_protected_append_writes", null)
      state                         = lookup(immutability_policy.value, "state", null)
      period_since_creation_in_days = lookup(immutability_policy.value, "period_since_creation_in_days", null)
    }
  }

  dynamic "sas_policy" {
    for_each = try(var.sas_policy, [])
    content {
      expiration_period = lookup(immutability_policy.value, "expiration_period", null)
      expiration_action = lookup(immutability_policy.value, "expiration_action", null)
    }
  }

  tags = merge(local.default_storage_account_tags, var.storage_account_tags)
  #checkov:skip=CKV2_AZURE_33:Private endpoint is implemented for this storage
  depends_on = [
    random_id.storage
  ]
}

resource "azurerm_log_analytics_storage_insights" "storage_insights" {
  name                = var.storage_insights_name
  resource_group_name = var.resource_group_name
  workspace_id        = var.log_analytics_workspace_id

  storage_account_id  = azurerm_storage_account.storage_account.id
  storage_account_key = azurerm_storage_account.storage_account.primary_access_key

  blob_container_names = var.storage_insights_blob_container_names
  table_names          = var.storage_insights_table_names
}

resource "azurerm_storage_container" "container" {
  count                             = try(length(var.storage_container_name), 0) > 0 ? 1 : 0

  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
  metadata              = var.container_metadata

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

#Create the private endpoint for dataplane storage (DBFS)
module "storage_dbfs_pe" {
  source = "../azure-private-endpoint"

  count                             = var.enable_dbfs_private_endpoint ? 1 : 0
  name                              = var.storage_account_dbfs_pe_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  subnet_id                         = var.storage_dbfs_pe_subnet_id
  custom_network_interface_name     = var.storage_dbfs_pe_custom_network_interface_name
  private_service_connection_name   = var.storage_dbfs_pe_private_service_connection_name
  private_connection_resource_id    = azurerm_storage_account.storage_account.id
  private_connection_resource_alias = var.storage_dbfs_pe_private_connection_resource_alias
  manual_connection                 = var.storage_dbfs_pe_manual_connection
  subresource_names                 = var.storage_dbfs_pe_subresource_names
  request_message                   = var.storage_dbfs_pe_request_message
  private_dns_zone_group_name       = var.storage_dbfs_pe_private_dns_zone_group_name
  private_dns_zone_ids              = var.storage_dbfs_private_dns_zone_ids
  ip_configurations                 = var.storage_dbfs_pe_ip_configurations
  env                               = var.env
  tags                              = merge(local.default_storage_dbfs_pe_tags, var.storage_dbfs_pe_tags)
  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

#Create the private endpoint for dataplane storage (Blob)
module "storage_blob_pe" {
  source = "../azure-private-endpoint"

  count                             = var.enable_blob_private_endpoint ? 1 : 0
  name                              = var.storage_account_blob_pe_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  subnet_id                         = var.storage_blob_pe_subnet_id
  custom_network_interface_name     = var.storage_blob_pe_custom_network_interface_name
  private_service_connection_name   = var.storage_blob_pe_private_service_connection_name
  private_connection_resource_id    = azurerm_storage_account.storage_account.id
  private_connection_resource_alias = var.storage_blob_pe_private_connection_resource_alias
  manual_connection                 = var.storage_blob_pe_manual_connection
  subresource_names                 = var.storage_blob_pe_subresource_names
  request_message                   = var.storage_blob_pe_request_message
  private_dns_zone_group_name       = var.storage_blob_pe_private_dns_zone_group_name
  private_dns_zone_ids              = var.storage_blob_private_dns_zone_ids
  ip_configurations                 = var.storage_blob_pe_ip_configurations
  env                               = var.env
  tags                              = merge(local.default_storage_blob_pe_tags, var.storage_blob_pe_tags)
  depends_on = [
    azurerm_storage_account.storage_account
  ]
}
