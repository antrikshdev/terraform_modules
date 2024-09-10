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

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_inbound_rules"></a> [inbound\_rules](#input\_inbound\_rules) | List of objects that represent the configuration of each inbound rule. | <pre>list(object(<br>    {<br>      name                                       = string<br>      priority                                   = string<br>      access                                     = string<br>      protocol                                   = string<br>      source_address_prefix                      = string<br>      source_address_prefixes                    = optional(list(string))<br>      source_port_range                          = optional(string)<br>      source_port_ranges                         = optional(list(string))<br>      source_application_security_group_ids      = optional(list(string))<br>      destination_address_prefix                 = optional(string)<br>      destination_address_prefixes               = optional(list(string))<br>      destination_port_range                     = optional(string)<br>      destination_port_ranges                    = optional(list(string))<br>      destination_application_security_group_ids = optional(list(string))<br>      description                                = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the network security group is created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the network security group. | `string` | n/a | yes |
| <a name="input_outbound_rules"></a> [outbound\_rules](#input\_outbound\_rules) | List of objects that represent the configuration of each outbound rule. | <pre>list(object(<br>    {<br>      name                                       = string<br>      priority                                   = string<br>      access                                     = string<br>      protocol                                   = string<br>      source_address_prefix                      = string<br>      source_address_prefixes                    = optional(list(string))<br>      source_port_range                          = optional(string)<br>      source_port_ranges                         = optional(list(string))<br>      source_application_security_group_ids      = optional(list(string))<br>      destination_address_prefix                 = optional(string)<br>      destination_address_prefixes               = optional(list(string))<br>      destination_port_range                     = optional(string)<br>      destination_port_ranges                    = optional(list(string))<br>      destination_application_security_group_ids = optional(list(string))<br>      description                                = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the network security group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The network security group configuration ID. |
| <a name="output_inbound_rules"></a> [inbound\_rules](#output\_inbound\_rules) | Blocks containing configuration of each inbound security rule. Usage: module.<MODULE\_NAME>.inbound\_rules["<INBOUND\_RULE\_NAME>"].id |
| <a name="output_location"></a> [location](#output\_location) | The location/region where the network security group is created. |
| <a name="output_name"></a> [name](#output\_name) | The name of the network security group. |
| <a name="output_outbound_rules"></a> [outbound\_rules](#output\_outbound\_rules) | Blocks containing configuration of each outbound security rule. Usage: module.<MODULE\_NAME>.outbound\_rules["<OUTBOUND\_RULE\_NAME>"].id |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group in which to create the network security group. |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags assigned to the network security group. |
<!-- END_TF_DOCS -->