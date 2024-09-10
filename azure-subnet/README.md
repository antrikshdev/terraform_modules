<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ../azure-nsg | n/a |
| <a name="module_route_table"></a> [route\_table](#module\_route\_table) | ../azure-route-table | n/a |
| <a name="module_route_table_association"></a> [route\_table\_association](#module\_route\_table\_association) | ../azure-route-table-association | n/a |
| <a name="module_subnet_nsg_association"></a> [subnet\_nsg\_association](#module\_subnet\_nsg\_association) | ../azure-nsg-association | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nat_gateway_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | The address prefixes to use for the subnet. | `list(string)` | n/a | yes |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | The list of delegations | <pre>list(<br>    object(<br>      {<br>        name = string # (Required) A name for this delegation.<br>        service_delegation = object({<br>          name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.<br>          actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.<br>        })<br>      }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_disable_bgp_route_propagation"></a> [disable\_bgp\_route\_propagation](#input\_disable\_bgp\_route\_propagation) | Boolean flag which controls propagation of routes learned by BGP on that route table. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_existing_nat_gateway_id"></a> [existing\_nat\_gateway\_id](#input\_existing\_nat\_gateway\_id) | The ID of an existing NAT gateway. | `string` | `null` | no |
| <a name="input_existing_nsg_id"></a> [existing\_nsg\_id](#input\_existing\_nsg\_id) | The ID of an existing network security group. | `string` | `null` | no |
| <a name="input_existing_route_table_id"></a> [existing\_route\_table\_id](#input\_existing\_route\_table\_id) | The ID of an existing route table. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to use for the subnet. | `string` | n/a | yes |
| <a name="input_nat_gateway_id"></a> [nat\_gateway\_id](#input\_nat\_gateway\_id) | The ID of the NAT Gateway which should be associated with the Subnet. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_nat_gateway_idle_timeout_in_minutes"></a> [nat\_gateway\_idle\_timeout\_in\_minutes](#input\_nat\_gateway\_idle\_timeout\_in\_minutes) | The idle timeout which should be used in minutes. Defaults to 4. | `number` | `4` | no |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | Specifies the name of the NAT Gateway. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_nat_gateway_sku_name"></a> [nat\_gateway\_sku\_name](#input\_nat\_gateway\_sku\_name) | The SKU which should be used. At this time the only supported value is Standard. | `string` | `null` | no |
| <a name="input_nat_gateway_tags"></a> [nat\_gateway\_tags](#input\_nat\_gateway\_tags) | A mapping of tags to assign to the nat gateway resource | `map(string)` | `{}` | no |
| <a name="input_nat_gateway_zones"></a> [nat\_gateway\_zones](#input\_nat\_gateway\_zones) | A list of Availability Zones in which this NAT Gateway should be located. | `list(string)` | `[]` | no |
| <a name="input_nsg_inbound_rules"></a> [nsg\_inbound\_rules](#input\_nsg\_inbound\_rules) | List of objects that represent the configuration of each inbound rule. | <pre>list(object(<br>    {<br>      name                                       = string<br>      priority                                   = string<br>      access                                     = string<br>      protocol                                   = string<br>      source_address_prefix                      = string<br>      source_address_prefixes                    = optional(list(string))<br>      source_port_range                          = string<br>      source_port_ranges                         = optional(list(string))<br>      source_application_security_group_ids      = optional(list(string))<br>      destination_address_prefix                 = string<br>      destination_address_prefixes               = optional(list(string))<br>      destination_port_range                     = string<br>      destination_port_ranges                    = optional(list(string))<br>      destination_application_security_group_ids = optional(list(string))<br>      description                                = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | The name of the network security group. | `string` | `null` | no |
| <a name="input_nsg_outbound_rules"></a> [nsg\_outbound\_rules](#input\_nsg\_outbound\_rules) | List of objects that represent the configuration of each outbound rule. | <pre>list(object(<br>    {<br>      name                                       = string<br>      priority                                   = string<br>      access                                     = string<br>      protocol                                   = string<br>      source_address_prefix                      = string<br>      source_address_prefixes                    = optional(list(string))<br>      source_port_range                          = string<br>      source_port_ranges                         = optional(list(string))<br>      source_application_security_group_ids      = optional(list(string))<br>      destination_address_prefix                 = string<br>      destination_address_prefixes               = optional(list(string))<br>      destination_port_range                     = string<br>      destination_port_ranges                    = optional(list(string))<br>      destination_application_security_group_ids = optional(list(string))<br>      description                                = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | Enable or Disable network policies for the private endpoint on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to use for the subnet. | `string` | n/a | yes |
| <a name="input_route_list"></a> [route\_list](#input\_route\_list) | List of objects representing routes | <pre>list(object({<br>    name                   = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_route_name"></a> [route\_name](#input\_route\_name) | The name of the route table. | `string` | `null` | no |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | The ID of the Route Table which should be associated with the Subnet. Changing this forces a new association to be created. | `string` | `null` | no |
| <a name="input_route_tags"></a> [route\_tags](#input\_route\_tags) | A mapping of tags to assign to the route table resource | `map(string)` | `{}` | no |
| <a name="input_service_endpoint_policy_ids"></a> [service\_endpoint\_policy\_ids](#input\_service\_endpoint\_policy\_ids) | The list of IDs of Service Endpoint Policies to associate with the subnet. | `set(string)` | `null` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of Service endpoints to associate with the subnet. Possible values include: `Microsoft.AzureActiveDirectory`, `Microsoft.AzureCosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage` and `Microsoft.Web`. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The virtual networkname to use for the subnet. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | ID of the created nsg |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the created subnet |
<!-- END_TF_DOCS -->