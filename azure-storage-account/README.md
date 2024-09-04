<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.48 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.6.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >=4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.6.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_blob_pe"></a> [storage\_blob\_pe](#module\_storage\_blob\_pe) | ../azure-private-endpoint | n/a |
| <a name="module_storage_dbfs_pe"></a> [storage\_dbfs\_pe](#module\_storage\_dbfs\_pe) | ../azure-private-endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_storage_insights.storage_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_storage_insights) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_id.storage](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. | `string` | n/a | yes |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | `null` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. | `string` | n/a | yes |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. Defaults to true. | `any` | `null` | no |
| <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope) | Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. | `string` | `null` | no |
| <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication) | A azure\_files\_authentication block. | <pre>list(object({<br>    storage_sid         = string<br>    domain_name         = string<br>    domain_sid          = string<br>    domain_guid         = string<br>    forest_name         = string<br>    netbios_domain_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | A blob\_properties block. | <pre>list(object({<br>    versioning_enabled                = optional(bool)<br>    change_feed_enabled               = optional(bool)<br>    change_feed_retention_in_days     = optional(number)<br>    default_service_version           = optional(string)<br>    last_access_time_enabled          = optional(bool)<br>    cors_rule                         = optional(list(any))<br>    delete_retention_policy           = optional(list(any))<br>    container_delete_retention_policy = optional(list(any))<br>  }))</pre> | <pre>[<br>  {<br>    "container_delete_retention_policy": [<br>      {<br>        "days": "7"<br>      }<br>    ],<br>    "delete_retention_policy": [<br>      {<br>        "days": "7"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | The access type of the storage container | `string` | `"private"` | no |
| <a name="input_container_metadata"></a> [container\_metadata](#input\_container\_metadata) | The metadata of the storage container | `map(any)` | `null` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | Should cross Tenant replication be enabled? Defaults to true. | `bool` | `null` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | A custom\_domain block. | <pre>list(object({<br>    name          = string<br>    use_subdomain = string<br>  }))</pre> | `[]` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | A customer\_managed\_key block. | <pre>list(object({<br>    key_vault_key_id          = string<br>    user_assigned_identity_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false. | `bool` | `null` | no |
| <a name="input_enable_blob_private_endpoint"></a> [enable\_blob\_private\_endpoint](#input\_enable\_blob\_private\_endpoint) | Whether to enable private endpoints for the blob. | `bool` | `true` | no |
| <a name="input_enable_dbfs_private_endpoint"></a> [enable\_dbfs\_private\_endpoint](#input\_enable\_dbfs\_private\_endpoint) | Whether to enable private endpoints for the dbfs. | `bool` | `true` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true. | `bool` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | A identity block. | <pre>list(object({<br>    key_vault_key_id          = string<br>    user_assigned_identity_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy) | An immutability\_policy block as defined below. Changing this forces a new resource to be created. | <pre>list(object({<br>    allow_protected_append_writes = bool<br>    state                         = string<br>    period_since_creation_in_days = number<br>  }))</pre> | `[]` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `null` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. | `bool` | `null` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | Is Large File Share Enabled? | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace within which the Storage Insights should exist. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. | `string` | `"TLS1_2"` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | A network\_rules block. | <pre>list(object({<br>    default_action             = string<br>    bypass                     = optional(list(string))<br>    ip_rules                   = optional(list(string))<br>    virtual_network_subnet_ids = optional(list(string))<br>    private_link_access        = optional(list(string))<br>  }))</pre> | <pre>[<br>  {<br>    "bypass": [<br>      "AzureServices"<br>    ],<br>    "default_action": "Deny"<br>  }<br>]</pre> | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | Is NFSv3 protocol enabled? Defaults to false. | `bool` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the public network access is enabled? Defaults to false. | `any` | `false` | no |
| <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type) | The encryption type of the queue service. Possible values are Service and Account. Default value is Service. | `string` | `null` | no |
| <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties) | A queue\_properties block | <pre>list(object({<br>    cors_rule      = list(any)<br>    logging        = list(any)<br>    minute_metrics = list(any)<br>    hour_metrics   = list(any)<br>  }))</pre> | <pre>[<br>  {<br>    "cors_rule": [],<br>    "hour_metrics": [],<br>    "logging": [<br>      {<br>        "delete": true,<br>        "read": true,<br>        "retention_policy_days": "15",<br>        "version": "1.0",<br>        "write": true<br>      }<br>    ],<br>    "minute_metrics": []<br>  }<br>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | A network\_rules block. | `list(any)` | `[]` | no |
| <a name="input_sas_policy"></a> [sas\_policy](#input\_sas\_policy) | A sas\_policy block. | <pre>list(object({<br>    expiration_period = string<br>    expiration_action = string<br>  }))</pre> | `[]` | no |
| <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled) | Boolean, enable SFTP for the storage account. | `bool` | `null` | no |
| <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties) | A share\_properties block. | <pre>list(object({<br>    cors_rule        = list(any)<br>    retention_policy = list(any)<br>    smb              = list(any)<br>  }))</pre> | `[]` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. | `bool` | `null` | no |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | A static\_website block. static\_website can only be set when the account\_kind is set to StorageV2 or BlockBlobStorage. | <pre>list(object({<br>    index_document     = string<br>    error_404_document = string<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_blob_pe_name"></a> [storage\_account\_blob\_pe\_name](#input\_storage\_account\_blob\_pe\_name) | The name of the storage account private endpoint. | `string` | `null` | no |
| <a name="input_storage_account_dbfs_pe_name"></a> [storage\_account\_dbfs\_pe\_name](#input\_storage\_account\_dbfs\_pe\_name) | The name of the storage account private endpoint. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. | `string` | n/a | yes |
| <a name="input_storage_account_tags"></a> [storage\_account\_tags](#input\_storage\_account\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_storage_blob_pe_custom_network_interface_name"></a> [storage\_blob\_pe\_custom\_network\_interface\_name](#input\_storage\_blob\_pe\_custom\_network\_interface\_name) | Name for the custom network interface | `string` | `null` | no |
| <a name="input_storage_blob_pe_ip_configurations"></a> [storage\_blob\_pe\_ip\_configurations](#input\_storage\_blob\_pe\_ip\_configurations) | IP configurations for the private endpoint | <pre>list(object({<br>    name               = string<br>    private_ip_address = string<br>    subresource_name   = string<br>    member_name        = string<br>  }))</pre> | `null` | no |
| <a name="input_storage_blob_pe_manual_connection"></a> [storage\_blob\_pe\_manual\_connection](#input\_storage\_blob\_pe\_manual\_connection) | Whether the connection is manually set or not. Defaults to false. | `bool` | `false` | no |
| <a name="input_storage_blob_pe_private_connection_resource_alias"></a> [storage\_blob\_pe\_private\_connection\_resource\_alias](#input\_storage\_blob\_pe\_private\_connection\_resource\_alias) | The alias for the resource that the private endpoint will connect to | `string` | `null` | no |
| <a name="input_storage_blob_pe_private_dns_zone_group_name"></a> [storage\_blob\_pe\_private\_dns\_zone\_group\_name](#input\_storage\_blob\_pe\_private\_dns\_zone\_group\_name) | Name of the private DNS zone group for the storage account | `string` | `null` | no |
| <a name="input_storage_blob_pe_private_service_connection_name"></a> [storage\_blob\_pe\_private\_service\_connection\_name](#input\_storage\_blob\_pe\_private\_service\_connection\_name) | Name for the private service connection | `string` | `null` | no |
| <a name="input_storage_blob_pe_request_message"></a> [storage\_blob\_pe\_request\_message](#input\_storage\_blob\_pe\_request\_message) | Message for the request | `string` | `null` | no |
| <a name="input_storage_blob_pe_subnet_id"></a> [storage\_blob\_pe\_subnet\_id](#input\_storage\_blob\_pe\_subnet\_id) | The subnet ID where the private endpoint will reside | `string` | `null` | no |
| <a name="input_storage_blob_pe_subresource_names"></a> [storage\_blob\_pe\_subresource\_names](#input\_storage\_blob\_pe\_subresource\_names) | The subresource names for the service to be connected | `list(string)` | <pre>[<br>  "blob"<br>]</pre> | no |
| <a name="input_storage_blob_pe_tags"></a> [storage\_blob\_pe\_tags](#input\_storage\_blob\_pe\_tags) | Tags for the private endpoint | `map(string)` | `{}` | no |
| <a name="input_storage_blob_private_dns_zone_ids"></a> [storage\_blob\_private\_dns\_zone\_ids](#input\_storage\_blob\_private\_dns\_zone\_ids) | List of private DNS zones for the storage account | `list(string)` | `[]` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | The name of the storage container | `string` | n/a | yes |
| <a name="input_storage_container_tags"></a> [storage\_container\_tags](#input\_storage\_container\_tags) | A mapping of tags to assign to the storage container | `map(string)` | `{}` | no |
| <a name="input_storage_dbfs_pe_custom_network_interface_name"></a> [storage\_dbfs\_pe\_custom\_network\_interface\_name](#input\_storage\_dbfs\_pe\_custom\_network\_interface\_name) | Name for the custom network interface | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_ip_configurations"></a> [storage\_dbfs\_pe\_ip\_configurations](#input\_storage\_dbfs\_pe\_ip\_configurations) | IP configurations for the private endpoint | <pre>list(object({<br>    name               = string<br>    private_ip_address = string<br>    subresource_name   = string<br>    member_name        = string<br>  }))</pre> | `null` | no |
| <a name="input_storage_dbfs_pe_manual_connection"></a> [storage\_dbfs\_pe\_manual\_connection](#input\_storage\_dbfs\_pe\_manual\_connection) | Whether the connection is manually set or not. Defaults to false. | `bool` | `false` | no |
| <a name="input_storage_dbfs_pe_private_connection_resource_alias"></a> [storage\_dbfs\_pe\_private\_connection\_resource\_alias](#input\_storage\_dbfs\_pe\_private\_connection\_resource\_alias) | The alias for the resource that the private endpoint will connect to | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_private_dns_zone_group_name"></a> [storage\_dbfs\_pe\_private\_dns\_zone\_group\_name](#input\_storage\_dbfs\_pe\_private\_dns\_zone\_group\_name) | Name of the private DNS zone group for the storage account | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_private_service_connection_name"></a> [storage\_dbfs\_pe\_private\_service\_connection\_name](#input\_storage\_dbfs\_pe\_private\_service\_connection\_name) | Name for the private service connection | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_request_message"></a> [storage\_dbfs\_pe\_request\_message](#input\_storage\_dbfs\_pe\_request\_message) | Message for the request | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_subnet_id"></a> [storage\_dbfs\_pe\_subnet\_id](#input\_storage\_dbfs\_pe\_subnet\_id) | The subnet ID where the private endpoint will reside | `string` | `null` | no |
| <a name="input_storage_dbfs_pe_subresource_names"></a> [storage\_dbfs\_pe\_subresource\_names](#input\_storage\_dbfs\_pe\_subresource\_names) | The subresource names for the service to be connected | `list(string)` | <pre>[<br>  "dfs"<br>]</pre> | no |
| <a name="input_storage_dbfs_pe_tags"></a> [storage\_dbfs\_pe\_tags](#input\_storage\_dbfs\_pe\_tags) | Tags for the private endpoint | `map(string)` | `{}` | no |
| <a name="input_storage_dbfs_private_dns_zone_ids"></a> [storage\_dbfs\_private\_dns\_zone\_ids](#input\_storage\_dbfs\_private\_dns\_zone\_ids) | List of private DNS zones for the storage account | `list(string)` | `[]` | no |
| <a name="input_storage_insights_blob_container_names"></a> [storage\_insights\_blob\_container\_names](#input\_storage\_insights\_blob\_container\_names) | The names of the blob containers that the workspace should read. | `list(string)` | `null` | no |
| <a name="input_storage_insights_name"></a> [storage\_insights\_name](#input\_storage\_insights\_name) | The name which should be used for this Log Analytics Storage Insights. | `string` | n/a | yes |
| <a name="input_storage_insights_table_names"></a> [storage\_insights\_table\_names](#input\_storage\_insights\_table\_names) | The names of the Azure tables that the workspace should read. | `list(string)` | `null` | no |
| <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type) | The encryption type of the table service. Possible values are Service and Account. Default value is Service. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | The name of the storage container |
<!-- END_TF_DOCS -->