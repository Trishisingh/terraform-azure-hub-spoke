resource "azurerm_resource_group" "network" {
  for_each = toset(local.all_resource_group_name)
  name     = each.key
  location = var.resource_group_location
  #tags     = var.tags
}

resource "azurerm_virtual_network" "example" {

  for_each            = { for i in var.network_details : i.name => i }
  name                = each.key
  location            = var.resource_group_location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = var.tags
  depends_on          = [azurerm_resource_group.network]
}


resource "azurerm_subnet" "example" {

  for_each                                      = { for i in toset(local.subnets) : i.sub_name => i }
  name                                          = each.key
  resource_group_name                           = each.value.resource_group_name
  virtual_network_name                          = each.value.vnet
  address_prefixes                              = each.value.sub_address_prefix
  service_endpoints                             = each.value.service_endpoints
  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  depends_on = [
    azurerm_virtual_network.example, azurerm_resource_group.network
  ]
}
