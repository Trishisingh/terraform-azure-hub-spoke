#Azure Generic vNet Module
data "azurerm_resource_group" "network" {
  count = var.existing_resource_group_name == null ? 0 : 1
  name  = var.existing_resource_group_name
}

resource "azurerm_resource_group" "network" {
  count    = var.existing_resource_group_name == null ? 1 : 0
  name     = var.resource_group_name
  location = var.resource_group_location
  # tags     = var.tags
}


resource "azurerm_virtual_network" "example" {

  for_each            = { for i in var.network_details : i.name => i }
  name                = each.key
  location            = azurerm_resource_group.network[0].location
  resource_group_name = azurerm_resource_group.network[0].name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

}


resource "azurerm_subnet" "example" {

  for_each             = { for i in toset(local.subnets) : i.sub_name => i }
  name                 = each.key
  resource_group_name  = azurerm_resource_group.network[0].name
  virtual_network_name = each.value.vnet
  address_prefixes     = each.value.sub_address_prefix

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
  depends_on = [
    azurerm_virtual_network.example
  ]
}
