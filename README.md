# terraform-azure-hub-spoke
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Resource Group Name | `string` | `null` | no |
| <a name="input_network_details"></a> [network\_details](#input\_network\_details) | n/a | <pre>map(object({<br>    name          = string<br>    address_space = list(string),<br>    dns_servers   = list(string),<br>    is_hub        = bool<br>    subnet_details = map(object({<br>      sub_name           = string,<br>      sub_address_prefix = list(string)<br>      })<br>    )<br><br>  }))</pre> | <pre>{<br>  "network1": {<br>    "address_space": [<br>      "10.1.0.0/16"<br>    ],<br>    "dns_servers": [<br>      "10.1.0.4",<br>      "10.1.0.5"<br>    ],<br>    "is_hub": true,<br>    "name": "network1",<br>    "subnet_details": {<br>      "sub1": {<br>        "sub_address_prefix": [<br>          "10.1.1.0/24"<br>        ],<br>        "sub_name": "subnet3"<br>      },<br>      "sub2": {<br>        "sub_address_prefix": [<br>          "10.1.2.0/24"<br>        ],<br>        "sub_name": "subnet4"<br>      }<br>    }<br>  },<br>  "network2": {<br>    "address_space": [<br>      "10.2.0.0/16"<br>    ],<br>    "dns_servers": [<br>      "10.2.0.4",<br>      "10.2.0.5"<br>    ],<br>    "is_hub": false,<br>    "name": "network2",<br>    "subnet_details": {<br>      "sub1": {<br>        "sub_address_prefix": [<br>          "10.2.1.0/24"<br>        ],<br>        "sub_name": "subnet1"<br>      },<br>      "sub2": {<br>        "sub_address_prefix": [<br>          "10.2.2.0/24"<br>        ],<br>        "sub_name": "subnet2"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | `"network-test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
<!-- END_TF_DOCS -->