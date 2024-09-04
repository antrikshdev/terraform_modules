<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.48.0 |
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
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | Name for the custom network interface | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations) | IP configurations for the private endpoint | <pre>list(object({<br>    name               = string<br>    private_ip_address = string<br>    subresource_name   = string<br>    member_name        = string<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region for the private endpoint | `string` | n/a | yes |
| <a name="input_manual_connection"></a> [manual\_connection](#input\_manual\_connection) | Whether the connection is manually set or not | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the private endpoint | `string` | n/a | yes |
| <a name="input_private_connection_resource_alias"></a> [private\_connection\_resource\_alias](#input\_private\_connection\_resource\_alias) | The alias for the resource that the private endpoint will connect to | `string` | `null` | no |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | The resource ID that the private endpoint will connect to | `string` | n/a | yes |
| <a name="input_private_dns_zone_group_name"></a> [private\_dns\_zone\_group\_name](#input\_private\_dns\_zone\_group\_name) | Name of the private DNS zone group | `string` | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | IDs for the private DNS zones | `list(string)` | n/a | yes |
| <a name="input_private_service_connection_name"></a> [private\_service\_connection\_name](#input\_private\_service\_connection\_name) | Name for the private service connection | `string` | n/a | yes |
| <a name="input_request_message"></a> [request\_message](#input\_request\_message) | Message for the request | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name where the private endpoint should be created | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID where the private endpoint will reside | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | The subresource names for the service to be connected | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the private endpoint | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoint_id"></a> [private\_endpoint\_id](#output\_private\_endpoint\_id) | The ID of the created private endpoint |
<!-- END_TF_DOCS -->