## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_service_pre"></a> [app\_service\_pre](#module\_app\_service\_pre) | ./modules/app_service | n/a |
| <a name="module_app_service_pro"></a> [app\_service\_pro](#module\_app\_service\_pro) | ./modules/app_service | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Entorno de despliegue: pre o pro | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"spaincentral"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"rg-ecoanalyzer"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `string` | `"F1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pre_app_url"></a> [pre\_app\_url](#output\_pre\_app\_url) | n/a |
| <a name="output_pro_app_url"></a> [pro\_app\_url](#output\_pro\_app\_url) | n/a |
