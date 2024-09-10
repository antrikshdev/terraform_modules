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
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | The BGP community attribute. | `string` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | A DDoS protection plan. | <pre>object({<br>    id     = string<br>    enable = string<br>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of IP addresses of DNS servers. | `list(string)` | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Specifies encryption support. | <pre>object({<br>    enforcement = string<br>  })</pre> | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes) | The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes | `number` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the Azure Region where the IP address exists. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to use for the virtual network. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to use for the virtual network. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the created virtual network |
| <a name="output_name"></a> [name](#output\_name) | Name of the created virtual network |
<!-- END_TF_DOCS -->