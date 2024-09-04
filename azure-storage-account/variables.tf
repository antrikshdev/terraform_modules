
variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account."
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
}

variable "account_replication_type" {
  type        = string
  default     = null
  description = "Defines the type of replication to use for this storage account."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account."
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = null
  description = "Should cross Tenant replication be enabled? Defaults to true."
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = null
  description = "Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true."
}

variable "allow_nested_items_to_be_public" {
  type        = any
  default     = null
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = null
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
}

variable "public_network_access_enabled" {
  type        = any
  default     = false
  description = "Whether the public network access is enabled? Defaults to false."
}

variable "default_to_oauth_authentication" {
  type        = bool
  default     = null
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
}

variable "is_hns_enabled" {
  type        = bool
  default     = null
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2."
}

variable "nfsv3_enabled" {
  type        = bool
  default     = null
  description = "Is NFSv3 protocol enabled? Defaults to false."
}

variable "sftp_enabled" {
  type        = bool
  default     = null
  description = "Boolean, enable SFTP for the storage account."
}

variable "allowed_copy_scope" {
  type        = string
  default     = null
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet."
}

variable "large_file_share_enabled" {
  type        = any
  default     = null
  description = "Is Large File Share Enabled?"
}

variable "queue_encryption_key_type" {
  type        = string
  default     = null
  description = "The encryption type of the queue service. Possible values are Service and Account. Default value is Service."
}

variable "table_encryption_key_type" {
  type        = string
  default     = null
  description = "The encryption type of the table service. Possible values are Service and Account. Default value is Service."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  default     = null
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
}

variable "custom_domain" {
  type = list(object({
    name          = string
    use_subdomain = string
  }))
  default     = []
  description = "A custom_domain block."
}

variable "customer_managed_key" {
  type = list(object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  }))
  default     = []
  description = "A customer_managed_key block."
}

variable "identity" {
  type = list(object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  }))
  default     = []
  description = "A identity block."
}

variable "sas_policy" {
  type = list(object({
    expiration_period = string
    expiration_action = string
  }))
  default     = []
  description = "A sas_policy block."
}


variable "network_rules" {
  type = list(object({
    default_action             = string
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_access        = optional(list(string))
  }))
  default = [{
    default_action = "Deny",
    bypass         = ["AzureServices"]
  }]
  description = "A network_rules block."
}

variable "azure_files_authentication" {
  type = list(object({
    storage_sid         = string
    domain_name         = string
    domain_sid          = string
    domain_guid         = string
    forest_name         = string
    netbios_domain_name = string
  }))
  default     = []
  description = "A azure_files_authentication block."
}

variable "blob_properties" {
  type = list(object({
    versioning_enabled                = optional(bool)
    change_feed_enabled               = optional(bool)
    change_feed_retention_in_days     = optional(number)
    default_service_version           = optional(string)
    last_access_time_enabled          = optional(bool)
    cors_rule                         = optional(list(any))
    delete_retention_policy           = optional(list(any))
    container_delete_retention_policy = optional(list(any))
  }))
  default = [{
    "delete_retention_policy" = [{
      "days" = "7"
    }]
    "container_delete_retention_policy" = [{
      "days" = "7"
    }]
  }]
  description = "A blob_properties block."
}

variable "queue_properties" {
  type = list(object({
    cors_rule      = list(any)
    logging        = list(any)
    minute_metrics = list(any)
    hour_metrics   = list(any)
  }))
  default = [{
    cors_rule = []
    logging = [{
      "delete"                = true,
      "read"                  = true,
      "write"                 = true,
      "version"               = "1.0",
      "retention_policy_days" = "15"
    }]
    minute_metrics = []
    hour_metrics   = []
  }]
  description = "A queue_properties block"
}
variable "share_properties" {
  type = list(object({
    cors_rule        = list(any)
    retention_policy = list(any)
    smb              = list(any)
  }))
  default     = []
  description = "A share_properties block."
}
variable "static_website" {
  type = list(object({
    index_document     = string
    error_404_document = string
  }))
  default     = []
  description = "A static_website block. static_website can only be set when the account_kind is set to StorageV2 or BlockBlobStorage."
}
variable "routing" {
  type        = list(any)
  default     = []
  description = "A network_rules block."
}
variable "immutability_policy" {
  type = list(object({
    allow_protected_append_writes = bool
    state                         = string
    period_since_creation_in_days = number
  }))
  default     = []
  description = "An immutability_policy block as defined below. Changing this forces a new resource to be created."
}
variable "storage_account_tags" {
  type        = map(any)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}


variable "storage_container_name" {
  type        = string
  description = "The name of the storage container"
}

variable "container_access_type" {
  type        = string
  default     = "private"
  description = "The access type of the storage container"
}

variable "container_metadata" {
  type        = map(any)
  default     = null
  description = "The metadata of the storage container"
}

variable "storage_container_tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the storage container"
}


variable "storage_account_dbfs_pe_name" {
  type        = string
  description = "The name of the storage account private endpoint."
  default = null
}

variable "storage_dbfs_pe_subnet_id" {
  type        = string
  description = "The subnet ID where the private endpoint will reside"
  default = null
}

variable "storage_dbfs_pe_custom_network_interface_name" {
  type        = string
  default     = null
  description = "Name for the custom network interface"
}

variable "storage_dbfs_pe_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the private endpoint"
}

variable "storage_dbfs_pe_private_service_connection_name" {
  type        = string
  description = "Name for the private service connection"
  default = null
}

variable "storage_dbfs_pe_private_connection_resource_alias" {
  type        = string
  default     = null
  description = "The alias for the resource that the private endpoint will connect to"
}

variable "storage_dbfs_pe_manual_connection" {
  type        = bool
  default     = false
  description = "Whether the connection is manually set or not. Defaults to false."
}

variable "storage_dbfs_pe_subresource_names" {
  type        = list(string)
  default     = ["dfs"]
  description = "The subresource names for the service to be connected"
}

variable "storage_dbfs_pe_request_message" {
  type        = string
  default     = null
  description = "Message for the request"
}

variable "storage_dbfs_pe_private_dns_zone_group_name" {
  type        = string
  description = "Name of the private DNS zone group for the storage account"
  default = null
}

variable "storage_dbfs_private_dns_zone_ids" {
  type        = list(string)
  description = "List of private DNS zones for the storage account"
  default = []
}

variable "storage_dbfs_pe_ip_configurations" {
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = string
    member_name        = string
  }))
  default     = null
  description = "IP configurations for the private endpoint"
}

variable "storage_account_blob_pe_name" {
  type        = string
  description = "The name of the storage account private endpoint."
  default = null
}

variable "storage_blob_pe_subnet_id" {
  type        = string
  description = "The subnet ID where the private endpoint will reside"
  default = null
}

variable "storage_blob_pe_custom_network_interface_name" {
  type        = string
  default     = null
  description = "Name for the custom network interface"
}

variable "storage_blob_pe_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the private endpoint"
}

variable "storage_blob_pe_private_service_connection_name" {
  type        = string
  description = "Name for the private service connection"
  default = null
}

variable "storage_blob_pe_private_connection_resource_alias" {
  type        = string
  default     = null
  description = "The alias for the resource that the private endpoint will connect to"
}

variable "storage_blob_pe_manual_connection" {
  type        = bool
  default     = false
  description = "Whether the connection is manually set or not. Defaults to false."
}

variable "storage_blob_pe_subresource_names" {
  type        = list(string)
  default     = ["blob"]
  description = "The subresource names for the service to be connected"
}

variable "storage_blob_pe_request_message" {
  type        = string
  default     = null
  description = "Message for the request"
}

variable "storage_blob_pe_private_dns_zone_group_name" {
  type        = string
  description = "Name of the private DNS zone group for the storage account"
  default = null
}

variable "storage_blob_private_dns_zone_ids" {
  type        = list(string)
  description = "List of private DNS zones for the storage account"
  default = []
}

variable "storage_blob_pe_ip_configurations" {
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = string
    member_name        = string
  }))
  default     = null
  description = "IP configurations for the private endpoint"
}


variable "storage_insights_name" {
  type        = string
  description = "The name which should be used for this Log Analytics Storage Insights."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace within which the Storage Insights should exist."
}

variable "storage_insights_blob_container_names" {
  type        = list(string)
  default     = null
  description = "The names of the blob containers that the workspace should read."
}

variable "storage_insights_table_names" {
  type        = list(string)
  default     = null
  description = "The names of the Azure tables that the workspace should read."
}

variable "env" {
  type        = string
  description = "The environment: dev, uat, preprod or prod."
  validation {
    condition     = contains(["dev", "uat", "preprod", "prod"], var.env)
    error_message = "The environment must be either dev, uat, preprod or prod."
  }
}

variable "enable_blob_private_endpoint" {
  type        = bool
  description = "Whether to enable private endpoints for the blob."
  default     = true
}

variable "enable_dbfs_private_endpoint" {
  type        = bool
  description = "Whether to enable private endpoints for the dbfs."
  default     = true
}