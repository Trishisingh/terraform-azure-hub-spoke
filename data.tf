data "azurerm_virtual_network" "hub_network" {
  name                =  local.hub_network_name[0]
  resource_group_name = azurerm_resource_group.network[0].name
  depends_on = [ azurerm_virtual_network.example ]
}
