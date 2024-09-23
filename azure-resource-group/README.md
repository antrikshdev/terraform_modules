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
| <a name="module_role-assignment-contributor"></a> [role-assignment-contributor](#module\_role-assignment-contributor) | ../azure-role-assignment | n/a |
| <a name="module_role-assignment-owner"></a> [role-assignment-owner](#module\_role-assignment-owner) | ../azure-role-assignment | n/a |
| <a name="module_role-assignment-reader"></a> [role-assignment-reader](#module\_role-assignment-reader) | ../azure-role-assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contributor_id"></a> [contributor\_id](#input\_contributor\_id) | The contributor ID used for role assignment. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment: dev, uat, preprod or prod. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location for the resource group deployment. | `string` | n/a | yes |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | The ID of the resource or application that manages this Resource Group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the resource group. | `string` | n/a | yes |
| <a name="input_owner_id"></a> [owner\_id](#input\_owner\_id) | The owner ID used for role assignment. | `string` | `null` | no |
| <a name="input_reader_id"></a> [reader\_id](#input\_reader\_id) | The reader ID used for role assignment. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id of the resource group |
| <a name="output_location"></a> [location](#output\_location) | Location of the resource group |
| <a name="output_name"></a> [name](#output\_name) | Name of the resource group |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags of the resource group |
<!-- END_TF_DOCS -->