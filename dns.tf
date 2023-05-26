resource "azurerm_private_dns_zone" "example" {
  count               = var.create_private_dns_zone ? 1 : 0
  name                = "privatelink.${var.dns_zone_name}.com"
  resource_group_name = local.hub_resource_group_name[0]
  tags                = var.tags
  depends_on          = [azurerm_resource_group.network]
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  for_each              = toset(local.dns_link_networks)
  name                  = "dns-link-${each.key}"
  resource_group_name   = local.hub_resource_group_name[0]
  registration_enabled  = var.registration_enabled
  private_dns_zone_name = azurerm_private_dns_zone.example[0].name
  virtual_network_id    = azurerm_virtual_network.example["${each.key}"].id
  depends_on            = [azurerm_resource_group.network]
}
