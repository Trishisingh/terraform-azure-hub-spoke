

resource "azurerm_virtual_network_peering" "hub-spoke" {
  for_each                  = toset(local.spoke_network_names)
  name                      = "hub-to-${each.key}"
  resource_group_name       = local.hub_resource_group_name[0]
  virtual_network_name      = local.hub_network_name[0]
  remote_virtual_network_id = azurerm_virtual_network.example[each.key].id
  depends_on                = [azurerm_resource_group.network, azurerm_virtual_network.example]

}


resource "azurerm_virtual_network_peering" "spoke-hub" {
  for_each                  = { for i in toset(local.spoke_network_names_resource_group_name) : i.name => i }
  name                      = "${each.key}-to-hub"
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = azurerm_virtual_network.example[each.key].name
  remote_virtual_network_id = azurerm_virtual_network.example["${local.hub_network_name[0]}"].id
  depends_on                = [azurerm_resource_group.network, azurerm_virtual_network.example]
}
