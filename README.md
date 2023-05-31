# terraform-azure-hub-spoke
<!-- BEGIN_TF_DOCS -->

[![Terraform](https://github.com/Trishisingh/terraform-azure-hub-spoke/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/Trishisingh/terraform-azure-hub-spoke/actions/workflows/terraform.yml)
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.54.0 |

## Example Usage
```hcl

#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  count = var.existing_resource_group_name == null ? 0 : 1
  name  = var.existing_resource_group_name
}

resource "azurerm_resource_group" "network" {
  count    = var.existing_resource_group_name == null ? 1 : 0
  name     = var.resource_group_name
  location = var.resource_group_location
  #tags     = var.tags
}


module "networking" {
  source                  = "../../azurerm-hub-spoke"
  enable_private_networks = true ## NOTE setting this value to false will cause no resources to be created !!
  network_details         = var.network_details
  resource_group_name     = azurerm_resource_group.network[0].name
  resource_group_location = azurerm_resource_group.network[0].location
  create_hub_fw           = true
  create_fw_public_ip     = false
  name_az_fw              = "testfirewall"
  sku_az_fw               = "AZFW_Hub"
  sku_tier_az_fw          = "Basic"
  create_private_dns_zone = true
}
```

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_private_dns_zone.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.az_fw_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.hub-spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke-hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_fw_public_ip"></a> [create\_fw\_public\_ip](#input\_create\_fw\_public\_ip) | weather to create a  public IP for Azure fierwall in hub network | `bool` | `false` | no |
| <a name="input_create_hub_fw"></a> [create\_hub\_fw](#input\_create\_hub\_fw) | weather to create a Azure fierwall in hub network | `bool` | `false` | no |
| <a name="input_create_private_dns_zone"></a> [create\_private\_dns\_zone](#input\_create\_private\_dns\_zone) | set value wether to create a private\_dns\_zone or not | `bool` | `true` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created. | `string` | `"mydomaintest.com"` | no |
| <a name="input_enable_private_networks"></a> [enable\_private\_networks](#input\_enable\_private\_networks) | wether to creare private networks or not. | `bool` | `true` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Resource Group Name | `string` | `null` | no |
| <a name="input_fw_public_allocation_method"></a> [fw\_public\_allocation\_method](#input\_fw\_public\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_fw_public_ip_name"></a> [fw\_public\_ip\_name](#input\_fw\_public\_ip\_name) | Specifies the name of the Public IP. Changing this forces a new Public IP to be created. | `string` | `"testip"` | no |
| <a name="input_fw_public_ip_sku"></a> [fw\_public\_ip\_sku](#input\_fw\_public\_ip\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created. | `string` | `"Basic"` | no |
| <a name="input_hub_fw_address_prefixes"></a> [hub\_fw\_address\_prefixes](#input\_hub\_fw\_address\_prefixes) | Addess prefix for hub azure firewall | `list(string)` | <pre>[<br>  "10.1.20.0/26"<br>]</pre> | no |
| <a name="input_ip_config_name_az_fw"></a> [ip\_config\_name\_az\_fw](#input\_ip\_config\_name\_az\_fw) | Specifies the name of the IP Configuration. | `string` | `"ip_configuration"` | no |
| <a name="input_name_az_fw"></a> [name\_az\_fw](#input\_name\_az\_fw) | Specifies the name of the Firewall. Changing this forces a new resource to be created. | `string` | `"testfirewall"` | no |
| <a name="input_network_details"></a> [network\_details](#input\_network\_details) | n/a | <pre>map(object({<br>    name                = string<br>    address_space       = list(string)<br>    dns_servers         = list(string)<br>    resource_group_name = string<br>    is_hub              = bool<br>    link_to_private_dns = bool<br>    subnet_details = map(object({<br>      sub_name                                      = string<br>      sub_address_prefix                            = list(string)<br>      private_endpoint_network_policies_enabled     = bool<br>      private_link_service_network_policies_enabled = bool<br>      service_endpoints                             = list(string)<br>      })<br>    )<br><br>  }))</pre> | <pre>{<br>  "network1": {<br>    "address_space": [<br>      "10.1.0.0/16"<br>    ],<br>    "dns_servers": [<br>      "10.1.0.4",<br>      "10.1.0.5"<br>    ],<br>    "is_hub": true,<br>    "link_to_private_dns": true,<br>    "name": "network1",<br>    "resource_group_name": "hub-rg",<br>    "subnet_details": {<br>      "sub1": {<br>        "private_endpoint_network_policies_enabled": true,<br>        "private_link_service_network_policies_enabled": true,<br>        "service_endpoints": [],<br>        "sub_address_prefix": [<br>          "10.1.1.0/24"<br>        ],<br>        "sub_name": "subnet3"<br>      }<br>    }<br>  },<br>  "network2": {<br>    "address_space": [<br>      "10.2.0.0/16"<br>    ],<br>    "dns_servers": [<br>      "10.2.0.4",<br>      "10.2.0.5"<br>    ],<br>    "is_hub": false,<br>    "link_to_private_dns": true,<br>    "name": "network2",<br>    "resource_group_name": "spoke1-rg",<br>    "subnet_details": {<br>      "sub1": {<br>        "private_endpoint_network_policies_enabled": true,<br>        "private_link_service_network_policies_enabled": true,<br>        "service_endpoints": [],<br>        "sub_address_prefix": [<br>          "10.2.1.0/24"<br>        ],<br>        "sub_name": "subnet1"<br>      },<br>      "sub2": {<br>        "private_endpoint_network_policies_enabled": true,<br>        "private_link_service_network_policies_enabled": true,<br>        "service_endpoints": [],<br>        "sub_address_prefix": [<br>          "10.2.2.0/24"<br>        ],<br>        "sub_name": "subnet2"<br>      }<br>    }<br>  },<br>  "network3": {<br>    "address_space": [<br>      "10.3.0.0/16"<br>    ],<br>    "dns_servers": [<br>      "10.3.0.4",<br>      "10.3.0.5"<br>    ],<br>    "is_hub": false,<br>    "link_to_private_dns": true,<br>    "name": "network3",<br>    "resource_group_name": "spoke2-rg",<br>    "subnet_details": {<br>      "sub1": {<br>        "private_endpoint_network_policies_enabled": true,<br>        "private_link_service_network_policies_enabled": true,<br>        "service_endpoints": [],<br>        "sub_address_prefix": [<br>          "10.3.1.0/24"<br>        ],<br>        "sub_name": "subnet5"<br>      },<br>      "sub2": {<br>        "private_endpoint_network_policies_enabled": true,<br>        "private_link_service_network_policies_enabled": true,<br>        "service_endpoints": [],<br>        "sub_address_prefix": [<br>          "10.3.2.0/24"<br>        ],<br>        "sub_name": "subnet6"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled) | Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false. | `bool` | `true` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | he Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created. | `string` | `"network-test"` | no |
| <a name="input_sku_az_fw"></a> [sku\_az\_fw](#input\_sku\_az\_fw) | SKU name of the Firewall. Possible values are AZFW\_Hub and AZFW\_VNet. Changing this forces a new resource to be created. | `string` | `"AZFW_Hub"` | no |
| <a name="input_sku_tier_az_fw"></a> [sku\_tier\_az\_fw](#input\_sku\_tier\_az\_fw) | SKU tier of the Firewall. Possible values are Premium, Standard and Basic. | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to be applied to all resources created as part of this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hub_firewall_id"></a> [hub\_firewall\_id](#output\_hub\_firewall\_id) | n/a |
| <a name="output_hub_net_id"></a> [hub\_net\_id](#output\_hub\_net\_id) | n/a |
| <a name="output_hub_net_name"></a> [hub\_net\_name](#output\_hub\_net\_name) | n/a |
| <a name="output_hub_pub_ip"></a> [hub\_pub\_ip](#output\_hub\_pub\_ip) | n/a |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | n/a |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
| <a name="output_vnets"></a> [vnets](#output\_vnets) | n/a |
<!-- END_TF_DOCS -->
