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
| [azurerm_virtual_network_peering.peer1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peer2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic_peer1"></a> [allow\_forwarded\_traffic\_peer1](#input\_allow\_forwarded\_traffic\_peer1) | Controls if forwarded traffic from VMs in the remote virtual network is allowed for the first peer. | `bool` | `false` | no |
| <a name="input_allow_forwarded_traffic_peer2"></a> [allow\_forwarded\_traffic\_peer2](#input\_allow\_forwarded\_traffic\_peer2) | Controls if forwarded traffic from VMs in the remote virtual network is allowed for the second peer. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit_peer1"></a> [allow\_gateway\_transit\_peer1](#input\_allow\_gateway\_transit\_peer1) | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network for the first peer. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit_peer2"></a> [allow\_gateway\_transit\_peer2](#input\_allow\_gateway\_transit\_peer2) | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network for the second peer. | `bool` | `false` | no |
| <a name="input_allow_virtual_network_access_peer1"></a> [allow\_virtual\_network\_access\_peer1](#input\_allow\_virtual\_network\_access\_peer1) | Controls if the VMs in the remote virtual network can access VMs in the local virtual network for the first peer. | `bool` | `true` | no |
| <a name="input_allow_virtual_network_access_peer2"></a> [allow\_virtual\_network\_access\_peer2](#input\_allow\_virtual\_network\_access\_peer2) | Controls if the VMs in the remote virtual network can access VMs in the local virtual network for the second peer. | `bool` | `true` | no |
| <a name="input_enable_double_peer"></a> [enable\_double\_peer](#input\_enable\_double\_peer) | Controls if the bidirectional peering should be created between local(first) and remote(second) virtual network | `bool` | `false` | no |
| <a name="input_peer1_name"></a> [peer1\_name](#input\_peer1\_name) | The name of the first virtual network peering | `string` | n/a | yes |
| <a name="input_peer2_name"></a> [peer2\_name](#input\_peer2\_name) | The name of the second virtual network peering | `string` | `null` | no |
| <a name="input_remote_virtual_network_id_peer1"></a> [remote\_virtual\_network\_id\_peer1](#input\_remote\_virtual\_network\_id\_peer1) | The full Azure resource ID of the remote virtual network for the first peer. | `string` | n/a | yes |
| <a name="input_remote_virtual_network_id_peer2"></a> [remote\_virtual\_network\_id\_peer2](#input\_remote\_virtual\_network\_id\_peer2) | The full Azure resource ID of the remote virtual network for the second peer. | `string` | `null` | no |
| <a name="input_resource_group_name_peer1"></a> [resource\_group\_name\_peer1](#input\_resource\_group\_name\_peer1) | The name of the resource group in which to create the virtual network peering for the first peer. | `string` | n/a | yes |
| <a name="input_resource_group_name_peer2"></a> [resource\_group\_name\_peer2](#input\_resource\_group\_name\_peer2) | The name of the resource group in which to create the virtual network peering for the second peer. | `string` | `null` | no |
| <a name="input_triggers_peer1"></a> [triggers\_peer1](#input\_triggers\_peer1) | A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network for the first peer. | `map(any)` | `null` | no |
| <a name="input_triggers_peer2"></a> [triggers\_peer2](#input\_triggers\_peer2) | A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network for the second peer. | `map(any)` | `null` | no |
| <a name="input_use_remote_gateways_peer1"></a> [use\_remote\_gateways\_peer1](#input\_use\_remote\_gateways\_peer1) | Controls if remote gateways can be used on the local virtual network for the first peer. | `bool` | `null` | no |
| <a name="input_use_remote_gateways_peer2"></a> [use\_remote\_gateways\_peer2](#input\_use\_remote\_gateways\_peer2) | Controls if remote gateways can be used on the local virtual network for the second peer. | `bool` | `null` | no |
| <a name="input_virtual_network_name_peer1"></a> [virtual\_network\_name\_peer1](#input\_virtual\_network\_name\_peer1) | The name of the virtual network for the first peer. | `string` | n/a | yes |
| <a name="input_virtual_network_name_peer2"></a> [virtual\_network\_name\_peer2](#input\_virtual\_network\_name\_peer2) | The name of the virtual network for the second peer. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer1_id"></a> [peer1\_id](#output\_peer1\_id) | ID of the created Virtual Network Peering for the first peer. |
| <a name="output_peer2_id"></a> [peer2\_id](#output\_peer2\_id) | ID of the created Virtual Network Peering for the second peer. |
<!-- END_TF_DOCS -->